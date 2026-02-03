import React from 'react'
import { Button, Form } from 'react-bootstrap'

function NgoProfile() {
  return (
    <div>  <Form>
      <Form.Group className="mb-3" controlId="exampleForm.ControlInput1">
        <Form.Label>Ngo Name</Form.Label>
        <Form.Control type="text" placeholder="NGO NAME" />
      </Form.Group>
      <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
        <Form.Label>Contact Person</Form.Label>
        <Form.Control type='text' placeholder="CONTACT PERSON"/>
      </Form.Group>
       <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
        <Form.Label>Phone</Form.Label>
        <Form.Control type='number' placeholder="PHONE"/>
      </Form.Group>
       <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
        <Form.Label>Email</Form.Label>
        <Form.Control type='text' placeholder="E-mail"/>
      </Form.Group>
       <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
        <Form.Label>Address</Form.Label>
        <Form.Control type='text' placeholder="ADDRESS"/>
      </Form.Group>
            <Button variant="primary">Update Profile</Button>

    </Form></div>
  )
}

export default NgoProfile