import './App.css'
import Login from './components/Login'
import 'bootstrap/dist/css/bootstrap.min.css';
import CampaignManagment from './components/ngo/CampaignManagment'
import NgoProfile from './components/ngo/NgoProfile'
import ViewReport from './ViewReport'
import { Route, Routes } from 'react-router-dom'
import ViewNotification from './components/ngo/ViewNotificaion'
import AddUpdates from './components/ngo/AddUpdates'
import ViewAppointments from './components/ngo/ViewAppointments'
import ViewDonor from './components/admin/ViewDonor'
import Viewpatient from './components/admin/Viewpatient'
import AddNgo from './components/admin/AddNgo'
import ViewNgo from './components/admin/ViewNgo'
import EditNgo from './components/admin/EditNgo'
import ViewFeedback from './components/admin/ViewFeedback'
import SendNotification from './components/admin/SendNotification'
import Report from './components/admin/Report'
import AdminDashboard from './components/admin/AdminDashboard'
import NgoDashboard from './components/ngo/NgoDashboard'
import ViewCampaigns from './components/ngo/ViewCampaigns'
import AddHairPost from './components/ngo/AddHairPost'
import ManageHairPosts from './components/ngo/ManageHairPosts'
import ViewPatientPosts from './components/ngo/ViewPatientPosts'
import NgoMyRequests from './components/ngo/NgoMyRequests'
import ViewComplaints from './components/admin/ViewComplaints'
import NgoComplaints from './components/ngo/NgoComplaints'
import NgoHairRequests from './components/ngo/NgoHairRequests'
import NgoDonorHairPosts from './components/ngo/NgoDonorHairPosts'
import NgoChat from './components/ngo/NgoChat'
import AdminPostStatus from './components/admin/AdminPostStatus'

function App() {

  return (
    <>
      {/* <ViewReport /> */}
      <Routes>
        <Route path='/' element={<Login/>}/>
        <Route path='/dashboardAdmin' element={<AdminDashboard/>}/>
        <Route path='/viewreport' element={<ViewReport/>}/> 
        <Route path='/CampaignManagement' element={<CampaignManagment/>}/> 
        <Route path='/ngoprofile' element={<NgoProfile/>}/> 
        <Route path='/viewnotification' element={<ViewNotification/>}/>
        <Route path='/addupdates' element={<AddUpdates/>}/>
        <Route path='/viewappoinments' element={<ViewAppointments/>}/>
        <Route path='/viewdonor' element={<ViewDonor/>}/>
        <Route path='/viewpatient' element={<Viewpatient/>}/>
        <Route path='/AddNgo' element={<AddNgo/>}/>
        <Route path='/ViewNgo' element={<ViewNgo/>}/>
        <Route path='/edit-ngo/:id' element={<EditNgo/>}/>
        <Route path='/ViewFeedback' element={<ViewFeedback/>}/>
        <Route path='/SendNotification' element={<SendNotification/>}/>
        <Route path='/Report' element={<Report/>}/>
        <Route path='/managecomplaints' element={<ViewComplaints/>}/>
        <Route path='/adminviewpoststatus' element={<AdminPostStatus/>}/>


        <Route path='/NgoDashboard' element={<NgoDashboard/>}/>
        <Route path='/ViewAppointments' element={<ViewAppointments/>}/>
        <Route path='/CampaignManagment' element={<CampaignManagment/>}/>
        <Route path="/ngo/view-campaigns" element={<ViewCampaigns />} />
        <Route path='/ViewReq' element={<NgoHairRequests/>}/>
        <Route path='/ViewNotification' element={<ViewNotification/>}/>
          <Route path='/AddUpdates' element={<AddUpdates/>}/>
          <Route path='/AddPost' element={<AddHairPost/>}/>
          <Route path='/managePost' element={<ManageHairPosts/>}/>
          <Route path='/ViewPatientPost' element={<ViewPatientPosts/>}/>
          <Route path='/Viewrequeststatus' element={<NgoMyRequests/>}/>
          <Route path='/ngo/complaits' element={<NgoComplaints/>}/>
          <Route path='/ngo/donorpost' element={<NgoDonorHairPosts/>}/>
          <Route path='/ngo/chat' element={<NgoChat/>}/>

           </Routes>
    </>
  )
}

export default App
