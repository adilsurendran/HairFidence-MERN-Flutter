import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'
import Login from './components/Login'
import ManUser from './components/admin/ManUser'
import 'bootstrap/dist/css/bootstrap.min.css';
import ViewComplaint from './components/admin/ViewComplaint'
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


        <Route path='/NgoDashboard' element={<NgoDashboard/>}/>
        <Route path='/ViewAppointments' element={<ViewAppointments/>}/>
        <Route path='/CampaignManagment' element={<CampaignManagment/>}/>
        <Route path="/ngo/view-campaigns" element={<ViewCampaigns />} />
        <Route path='/ViewReport' element={<ViewReport/>}/>
        <Route path='/ViewNotification' element={<ViewNotification/>}/>
          <Route path='/AddUpdates' element={<AddUpdates/>}/>
          <Route path='/AddPost' element={<AddHairPost/>}/>
          <Route path='/managePost' element={<ManageHairPosts/>}/>

           </Routes>
    </>
  )
}

export default App
