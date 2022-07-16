//
//  AppointmentsViewController.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import UIKit
import Lottie

class AppointmentsViewController: UIViewController {
  //Object connections
  @IBOutlet private weak var statusbarBackgroundView: UIView!
  @IBOutlet private weak var noappointmentTitleLabel: UILabel!
  @IBOutlet private weak var noappointmentSubtitleLabel: UILabel!
  @IBOutlet private weak var noAppointmentImage: UIImageView!
  @IBOutlet private weak var createAppointmentButton: UIButton!
  @IBOutlet private weak var noAppointmentView: UIView!
  @IBOutlet private weak var appointmentsTableView: UITableView!
  private var animationView = AnimationView() // initialize animation
  private var refreshControl: UIRefreshControl? // refresh control for pull to refresh
  private var viewModel = AppointmentsViewModel()
  private var tableViewHelper: AppointmentsTableViewHelper!
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    localization()
    setupPullToRefresh()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setupLoadingAnimation()
    setupController()
  }
  
  func setupPullToRefresh() {
    refreshControl = UIRefreshControl()
    appointmentsTableView.addSubview(refreshControl!)
    refreshControl!.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged) // add table view pull to refresh action
  }
  
  @objc
  func callPullToRefresh() {
    viewModel.fetchAppointments()
  }
  
  /// Creates loading animation for current view
  func setupLoadingAnimation() {
    animationView.animation = Themes.loadingAnimation // setup animation gif
    animationView.frame = view.bounds // get the view frame
    animationView.contentMode = .scaleAspectFit
    view.addSubview(animationView) // add the animation as subview
    animationView.animationSpeed = 0.8 // set animation speed
    animationView.loopMode = .loop // set as loop
    animationView.play() // start animating
  }
  /// Stop and remove animation from the super view
  func removeAnimation() {
    animationView.stop()
    animationView.removeFromSuperview()
  }
  
  /// Setup UI Elements
  func setupUI() {
    statusbarBackgroundView.backgroundColor = Themes.colorCharcoal
    noappointmentTitleLabel.textColor = Themes.colorSolidWhite
    noappointmentTitleLabel.font = Themes.fontExtraBold
    noappointmentSubtitleLabel.font = Themes.fontRegularSubtitle
    noappointmentSubtitleLabel.textColor = Themes.colorGrayScale
    createAppointmentButton.tintColor = Themes.colorDark
    createAppointmentButton.backgroundColor = Themes.colorSolidWhite
    createAppointmentButton.layer.cornerRadius = ObjectConstants.buttonBorderRadius
    createAppointmentButton.titleLabel?.font = Themes.fontRegularSubtitle
    noAppointmentImage.image = Themes.noAppointmentImage
    self.navigationItem.hidesBackButton = true // hide back navbar button
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: Themes.UserImage, style: .plain, target: self, action: #selector(profileClicked))
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil) // with this we will disable back button label text
    appointmentsTableView.isHidden = true // make both the view hidden to show loading animation
    noAppointmentView.isHidden = true
    refreshControl?.tintColor = .green
  }
  
  // Setup UI Elements according to app language
  func localization() {
    self.navigationItem.title = "appointmentTitle".localizeString()
    noappointmentTitleLabel.text = "noAppointmentsTitle".localizeString()
    noappointmentSubtitleLabel.text = "noAppointmentsInfo".localizeString()
    createAppointmentButton.setTitle("createAppointmentButton".localizeString(), for: .normal)
  }
  /// setup vm and tableview helper
  func setupController() {
    viewModel.fetchAppointments() // fetch the appointments
    tableViewHelper = .init(with: appointmentsTableView, vm: viewModel) // initialize tableviewhelper
    tableViewHelper.delegate = self // get delegation
    
    viewModel.onAppointmentsChanged = { [weak self] currentAppointment, pastAppointments in // when  appointments received
      self?.removeAnimation()
      self?.refreshControl?.endRefreshing() // end animation
      self?.tableViewHelper.setItems(currentAppointments: currentAppointment, pastAppointments: pastAppointments)
      if currentAppointment.isEmpty && pastAppointments.isEmpty { //  if there is no appointment show no appointment view
        self?.appointmentsTableView.isHidden = true
        self?.noAppointmentView.isHidden = false
      }else {
        self?.appointmentsTableView.isHidden = false
        self?.noAppointmentView.isHidden = true
      }
    }
    
    viewModel.onAppointmentsError = { [weak self] receivedError in // if any error occurred during the process
      self?.openErrorPopUp(error: receivedError)
    }
  }
  
  @objc
  func profileClicked() { // when profile image pressed
    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileView")
    self.navigationController?.pushViewController(vc, animated: true)
  }
  // open custom error pop up view
  func openErrorPopUp(error: String, appointmentID: String? = nil, stationName: String? = nil,date: String? = nil ,time: String? = nil) {
    let popvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomPopup") as! CustomPopupViewController // instantiate custom popup view
    UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController!.addChild(popvc)
    popvc.view.frame = UIScreen.main.bounds
    UIApplication.shared.windows.last!.addSubview(popvc.view)
    
    if error == "DELETEAPPOINTMENT" { // if the selected date is past we will show the error page according to that
      
      let localizedMsg = String(format: NSLocalizedString("Your appointment at %@ on %@ at %@ will be cancelled.", comment: ""), stationName as! NSString, date as! NSString, time as! NSString) // localize popup mesage
      
      popvc.setupObjects(
        title: "cancelAppointmentTitle".localizeString(),
        subtitle: localizedMsg,
        confirmButtonLabel:  "confirmButton".localizeString(),
        cancelButtonLabel: "confirmCancelButton".localizeString()) // setup pop up elements
      
      popvc.didMove(toParent: self) // open popup
      popvc.confirmPressed = { [weak self] response in
        self?.viewModel.deleteAppointment(appointmentID: appointmentID!)//delete appointment
      } // handle received button press action
    }else if error == "maxNumberAppointmentsReached"{ // HANDLE IF there is more than 10 appointments error
      popvc.setupObjects(
        title: "maxNumberAppointmentsReachedTitle".localizeString(),
        subtitle: "maxNumberAppointmentsReachedSubTitle".localizeString(),
        confirmButtonLabel:  "maxNumberAppointmentsReachedButton".localizeString(),
        cancelButtonLabel: "zero".localizeString(),
        hideSecondButton: true)
      popvc.didMove(toParent: self) // open it
    }else {
      popvc.setupObjects(
        title: "receivedServerErrorTitle".localizeString(),
        subtitle: "error".localizeString(),
        confirmButtonLabel:  "receivedServerErrorButtonTitle".localizeString(),
        cancelButtonLabel: "zero".localizeString(),
        hideSecondButton: true)
      popvc.didMove(toParent: self)
    }
  }
  // to presses next  page
  @IBAction func createAppointmentPressed(_ sender: UIButton) {
    if viewModel.shouldNavigateNextPage() { //if the number of the appointments higher than 10 we will show error popup
      let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitySelection")
      self.navigationController?.pushViewController(vc, animated: true)
    }else {
      openErrorPopUp(error: "maxNumberAppointmentsReached")
    }
  }
}

//MARK: - AppointmentViewProtocol
extension AppointmentsViewController: AppointmentViewProtocol {
  func didDeletionSelected(appointmentID: String, stationName: String, date: String, time: String) {
    openErrorPopUp(error: "DELETEAPPOINTMENT", appointmentID: appointmentID, stationName: stationName, date: date, time: time)
  }
}
