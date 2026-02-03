import React from 'react'
import Form from 'react-bootstrap/Form'
import Button from 'react-bootstrap/Button'
import NgoSidebar from './NgoSidebar'
import './addUpdates.css'

function AddUpdates() {
  return (
    <div className="update-wrapper">
      <NgoSidebar />

      <div className="update-main">
        <h1 className="update-title">Add Updates</h1>

        <div className="update-card">
          <Form>
            <Form.Group className="mb-3">
              <Form.Label>Update Title</Form.Label>
              <Form.Control type="text" placeholder="Enter update title" />
            </Form.Group>

            <Form.Group className="mb-3">
              <Form.Label>Update Message</Form.Label>
              <Form.Control
                as="textarea"
                rows={4}
                placeholder="Enter update message"
              />
            </Form.Group>

            <Form.Group className="mb-4">
              <Form.Label>Date</Form.Label>
              <Form.Control type="date" />
            </Form.Group>

            <Button className="update-btn">Post Update</Button>
          </Form>
        </div>
      </div>
    </div>
  )
}

export default AddUpdates
