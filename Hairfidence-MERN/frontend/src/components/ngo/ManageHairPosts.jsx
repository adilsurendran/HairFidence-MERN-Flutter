// import { useEffect, useState } from "react";
// import Button from "react-bootstrap/Button";
// import Modal from "react-bootstrap/Modal";
// import Form from "react-bootstrap/Form";
// import api from "../apiInterceptor";
// import "./manageHairPosts.css";
// import NgoSidebar from "./NgoSidebar";


// function ManageHairPosts() {
//   const profileId = localStorage.getItem("profileId");

//   const [posts, setPosts] = useState([]);
//   const [show, setShow] = useState(false);
//   const [currentId, setCurrentId] = useState(null);

//   const [formData, setFormData] = useState({
//     title: "",
//     hairLength: "",
//     hairType: "",
//     hairColor: "",
//     chemicallyTreated: "no",
//     greyHair: "no",
//     quantity: "",
//     condition: "",
//     location: "",
//     description: "",
//   });

//   /* FETCH */
//   const fetchPosts = async () => {
//     const res = await api.get(`/hair-posts/${profileId}`);
//     setPosts(res.data);
//     console.log(res);
    
//   };

//   useEffect(() => {
//     fetchPosts();
//   }, []);

//   /* DELETE */
//   const deletePost = async (id) => {
//     if (!window.confirm("Delete this hair post?")) return;

//     await api.delete(`/hair-posts/${id}/${profileId}`);
//     fetchPosts();
//   };

//   /* OPEN EDIT MODAL */
//   const openEditModal = (post) => {
//     setCurrentId(post._id);
//     setFormData({
//       title: post.title,
//       hairLength: post.hairLength,
//       hairType: post.hairType,
//       hairColor: post.hairColor,
//       chemicallyTreated: post.chemicallyTreated,
//       greyHair: post.greyHair,
//       quantity: post.quantity,
//       condition: post.condition,
//       location: post.location,
//       description: post.description,
//     });
//     setShow(true);
//   };

//   /* CHANGE */
//   const handleChange = (e) =>
//     setFormData({
//       ...formData,
//       [e.target.name]: e.target.value,
//     });

//   /* UPDATE */
//   const handleUpdate = async () => {
//     await api.put(`/hair-posts/${currentId}`, {
//       ...formData,
//       profileId,
//     });

//     setShow(false);
//     fetchPosts();
//   };

//   return (
//         <div className="ngo-container">
//       <NgoSidebar />

//       <div className="ngo-content">
//     <div>
//       <h2 className="hairpost-title">Manage Hair Posts</h2>

//       {posts.length === 0 && <p>No hair posts found.</p>}

//       {posts.map((p) => (
//         <div key={p._id} className="hairpost-card">
//           <h4>{p.title}</h4>
//           <p>{p.hairLength} cm • {p.hairType}</p>
//           <p>{p.hairColor} • {p.condition}</p>
//           <p>Quantity - {p.quantity}</p>

//           <div style={{ display: "flex", gap: "10px" }}>
//             <Button variant="primary" onClick={() => openEditModal(p)}>
//               Edit
//             </Button>

//             <Button variant="danger" onClick={() => deletePost(p._id)}>
//               Delete
//             </Button>
//           </div>
//         </div>
//       ))}

//       {/* EDIT MODAL */}
//       <Modal show={show} onHide={() => setShow(false)} centered>
//         <Modal.Header closeButton>
//           <Modal.Title>Edit Hair Post</Modal.Title>
//         </Modal.Header>

//         <Modal.Body>
//           <Form>
//             <Form.Group className="mb-2">
//               <Form.Label>Title</Form.Label>
//               <Form.Control
//                 name="title"
//                 value={formData.title}
//                 onChange={handleChange}
//               />
//             </Form.Group>

//             <Form.Group className="mb-2">
//               <Form.Label>Hair Length (cm)</Form.Label>
//               <Form.Control
//                 type="number"
//                 name="hairLength"
//                 value={formData.hairLength}
//                 onChange={handleChange}
//               />
//             </Form.Group>

//             <Form.Group className="mb-2">
//               <Form.Label>Hair Type</Form.Label>
//               <Form.Select
//                 name="hairType"
//                 value={formData.hairType}
//                 onChange={handleChange}
//               >
//                 <option>Straight</option>
//                 <option>Wavy</option>
//                 <option>Curly</option>
//               </Form.Select>
//             </Form.Group>

//             <Form.Group className="mb-2">
//               <Form.Label>Hair Color</Form.Label>
//               <Form.Select
//                 name="hairColor"
//                 value={formData.hairColor}
//                 onChange={handleChange}
//               >
//                 <option>Black</option>
//                 <option>Brown</option>
//                 <option>Dark Brown</option>
//                 <option>Mixed</option>
//               </Form.Select>
//             </Form.Group>

//             <Form.Group className="mb-2">
//               <Form.Label>Quantity</Form.Label>
//               <Form.Control
//                 type="number"
//                 name="quantity"
//                 value={formData.quantity}
//                 onChange={handleChange}
//               />
//             </Form.Group>

//             <Form.Group className="mb-2">
//               <Form.Label>Condition</Form.Label>
//               <Form.Select
//                 name="condition"
//                 value={formData.condition}
//                 onChange={handleChange}
//               >
//                 <option>Excellent</option>
//                 <option>Good</option>
//                 <option>Average</option>
//               </Form.Select>
//             </Form.Group>

//             <Form.Group className="mb-2">
//               <Form.Label>Location</Form.Label>
//               <Form.Control
//                 name="location"
//                 value={formData.location}
//                 onChange={handleChange}
//               />
//             </Form.Group>

//             <Form.Group className="mb-2">
//               <Form.Label>Description</Form.Label>
//               <Form.Control
//                 as="textarea"
//                 rows={2}
//                 name="description"
//                 value={formData.description}
//                 onChange={handleChange}
//               />
//             </Form.Group>
//           </Form>
//         </Modal.Body>

//         <Modal.Footer>
//           <Button variant="secondary" onClick={() => setShow(false)}>
//             Cancel
//           </Button>
//           <Button variant="success" onClick={handleUpdate}>
//             Update
//           </Button>
//         </Modal.Footer>
//       </Modal>
//     </div>
//     </div>
//     </div>
//   );
// }

// export default ManageHairPosts;

import { useEffect, useState } from "react";
import Button from "react-bootstrap/Button";
import Modal from "react-bootstrap/Modal";
import Form from "react-bootstrap/Form";
import api from "../apiInterceptor";
import "./manageHairPosts.css";
import NgoSidebar from "./NgoSidebar";

function ManageHairPosts() {
  const profileId = localStorage.getItem("profileId");

  const [posts, setPosts] = useState([]);
  const [show, setShow] = useState(false);
  const [currentId, setCurrentId] = useState(null);

  const [formData, setFormData] = useState({
    title: "",
    hairLength: "",
    hairType: "",
    hairColor: "",
    chemicallyTreated: "no",
    greyHair: "no",
    quantity: "",
    condition: "",
    location: "",
    description: "",
  });

  /* FETCH */
  const fetchPosts = async () => {
    const res = await api.get(`/hair-posts/${profileId}`);
    setPosts(res.data);
  };

  useEffect(() => {
    fetchPosts();
  }, []);

  /* DELETE */
  const deletePost = async (id) => {
    if (!window.confirm("Delete this hair post?")) return;

    await api.delete(`/hair-posts/${id}/${profileId}`);
    fetchPosts();
  };

  /* OPEN EDIT MODAL */
  const openEditModal = (post) => {
    setCurrentId(post._id);
    setFormData({
      title: post.title,
      hairLength: post.hairLength,
      hairType: post.hairType,
      hairColor: post.hairColor,
      chemicallyTreated: post.chemicallyTreated,
      greyHair: post.greyHair,
      quantity: post.quantity,
      condition: post.condition,
      location: post.location,
      description: post.description,
    });
    setShow(true);
  };

  /* CHANGE */
  const handleChange = (e) =>
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });

  /* UPDATE */
  const handleUpdate = async () => {
    await api.put(`/hair-posts/${currentId}`, {
      ...formData,
      profileId,
    });

    setShow(false);
    fetchPosts();
  };

  return (
    <div className="ngo-container">
      <NgoSidebar />

      <div className="ngo-content">
        <div>
          <h2 className="hairpost-title">Manage Hair Posts</h2>

          {posts.length === 0 && <p>No hair posts found.</p>}

          {posts.map((p) => (
            <div key={p._id} className="hairpost-card">
              <h4>{p.title}</h4>
              <p>
                {p.hairLength} cm • {p.hairType}
              </p>
              <p>
                {p.hairColor} • {p.condition}
              </p>
              <p>Quantity - {p.quantity}</p>

              {/* ✅ CONDITION APPLIED HERE */}
              {p.status === "closed" ? (
                <p style={{ color: "lightgreen", fontWeight: "bold" }}>
                  Post Closed
                </p>
              ) : (
                <div style={{ display: "flex", gap: "10px" }}>
                  <Button variant="primary" onClick={() => openEditModal(p)}>
                    Edit
                  </Button>

                  <Button
                    variant="danger"
                    onClick={() => deletePost(p._id)}
                  >
                    Delete
                  </Button>
                </div>
              )}
            </div>
          ))}

          {/* EDIT MODAL */}
          <Modal show={show} onHide={() => setShow(false)} centered>
            <Modal.Header closeButton>
              <Modal.Title>Edit Hair Post</Modal.Title>
            </Modal.Header>

            <Modal.Body>
              <Form>
                <Form.Group className="mb-2">
                  <Form.Label>Title</Form.Label>
                  <Form.Control
                    name="title"
                    value={formData.title}
                    onChange={handleChange}
                  />
                </Form.Group>

                <Form.Group className="mb-2">
                  <Form.Label>Hair Length (cm)</Form.Label>
                  <Form.Control
                    type="number"
                    name="hairLength"
                    value={formData.hairLength}
                    onChange={handleChange}
                  />
                </Form.Group>

                <Form.Group className="mb-2">
                  <Form.Label>Hair Type</Form.Label>
                  <Form.Select
                    name="hairType"
                    value={formData.hairType}
                    onChange={handleChange}
                  >
                    <option>Straight</option>
                    <option>Wavy</option>
                    <option>Curly</option>
                  </Form.Select>
                </Form.Group>

                <Form.Group className="mb-2">
                  <Form.Label>Hair Color</Form.Label>
                  <Form.Select
                    name="hairColor"
                    value={formData.hairColor}
                    onChange={handleChange}
                  >
                    <option>Black</option>
                    <option>Brown</option>
                    <option>Dark Brown</option>
                    <option>Mixed</option>
                  </Form.Select>
                </Form.Group>

                <Form.Group className="mb-2">
                  <Form.Label>Quantity</Form.Label>
                  <Form.Control
                    type="number"
                    name="quantity"
                    value={formData.quantity}
                    onChange={handleChange}
                  />
                </Form.Group>

                <Form.Group className="mb-2">
                  <Form.Label>Condition</Form.Label>
                  <Form.Select
                    name="condition"
                    value={formData.condition}
                    onChange={handleChange}
                  >
                    <option>Excellent</option>
                    <option>Good</option>
                    <option>Average</option>
                  </Form.Select>
                </Form.Group>

                <Form.Group className="mb-2">
                  <Form.Label>Location</Form.Label>
                  <Form.Control
                    name="location"
                    value={formData.location}
                    onChange={handleChange}
                  />
                </Form.Group>

                <Form.Group className="mb-2">
                  <Form.Label>Description</Form.Label>
                  <Form.Control
                    as="textarea"
                    rows={2}
                    name="description"
                    value={formData.description}
                    onChange={handleChange}
                  />
                </Form.Group>
              </Form>
            </Modal.Body>

            <Modal.Footer>
              <Button variant="secondary" onClick={() => setShow(false)}>
                Cancel
              </Button>
              <Button variant="success" onClick={handleUpdate}>
                Update
              </Button>
            </Modal.Footer>
          </Modal>
        </div>
      </div>
    </div>
  );
}

export default ManageHairPosts;
