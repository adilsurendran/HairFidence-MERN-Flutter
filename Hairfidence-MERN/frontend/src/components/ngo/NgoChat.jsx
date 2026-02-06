import React, { useEffect, useState } from "react";
import api from "../apiInterceptor";
import NgoSidebar from "./NgoSidebar";
import "./ngoChat.css";
import { FaPlus } from "react-icons/fa";

const NgoChat = () => {
  const profileId = localStorage.getItem("profileId");

  const [chatList, setChatList] = useState([]);
  const [selectedChat, setSelectedChat] = useState(null);
  const [messages, setMessages] = useState([]);
  const [newMessage, setNewMessage] = useState("");

  const [showDonors, setShowDonors] = useState(false);
  const [donors, setDonors] = useState([]);

  /* ================= LOAD CHAT LIST ================= */
  const loadChats = async () => {
    const res = await api.post("/chat/my", {
      profileId,
      profileRole: "ngo",
    });
    setChatList(res.data);
  };

  /* ================= LOAD MESSAGES ================= */
  const loadMessages = async (conversationId) => {
    const res = await api.get(`/chat/messages/${conversationId}`);
    setMessages(res.data);
  };

  /* ================= OPEN CHAT ================= */
//   const openChat = (chat) => {
//     setSelectedChat(chat);
//     loadMessages(chat.conversationId);
//   };
const openChat = async (chat) => {
  setSelectedChat(chat);
  await loadMessages(chat.conversationId);

  await api.post("/chat/mark-read", {
    conversationId: chat.conversationId,
    profileId,
  });

  loadChats(); // refresh unread count
};


  /* ================= SEND MESSAGE ================= */
  const sendMessage = async () => {
    if (!newMessage.trim() || !selectedChat) return;

    await api.post("/chat/send", {
      conversationId: selectedChat.conversationId,
      senderId: profileId,
      senderRole: "ngo",
      message: newMessage,
    });

    setNewMessage("");
    loadMessages(selectedChat.conversationId);
    loadChats();
  };

  /* ================= LOAD DONORS ================= */
  const loadDonors = async () => {
    const res = await api.get(`/chat/donors/by-ngo/${profileId}`);
    setDonors(res.data);
    setShowDonors(true);
  };

  /* ================= START CHAT WITH DONOR ================= */
  const startChatWithDonor = async (donor) => {
    const res = await api.post("/chat/create-or-get", {
      profileId,
      profileRole: "ngo",
      otherProfileId: donor._id,
      otherProfileRole: "donor",
    });

    setShowDonors(false);
    loadChats();

    const chat = {
      conversationId: res.data.conversationId,
      name: donor.name,
      role: "donor",
    };

    setSelectedChat(chat);
    loadMessages(chat.conversationId);
  };

  /* ================= INITIAL LOAD ================= */
  useEffect(() => {
    loadChats();
  }, []);

  return (
    <div className="ngo-chat-wrapper">
      <NgoSidebar />

      <div className="ngo-chat-main">
        <h1 className="ngo-chat-title">Chats</h1>

        <div className="ngo-chat-card">
          {/* LEFT CHAT LIST */}
          <div className="chat-list">
            <div className="chat-list-header">
              <span>Conversations</span>
              <FaPlus className="chat-plus" onClick={loadDonors} />
            </div>

            {chatList.length === 0 && (
              <p className="chat-empty">No conversations yet</p>
            )}

            {chatList.map((chat) => (
              <div
                key={chat.conversationId}
                className={`chat-list-item ${
                  selectedChat?.conversationId === chat.conversationId
                    ? "active"
                    : ""
                }`}
                onClick={() => openChat(chat)}
              >
                <div className="chat-name">
                  {chat.name}
                  <small> ({chat.role})</small>
                </div>

                <div className="chat-last">
                  {chat.lastMessage || "No messages yet"}
                </div>

                {chat.unreadCount > 0 && (
                  <span className="chat-unread">{chat.unreadCount}</span>
                )}
              </div>
            ))}
          </div>

          {/* RIGHT CHAT WINDOW */}
          <div className="chat-window">
            {!selectedChat ? (
              <div className="chat-placeholder">
                Select a chat to start conversation
              </div>
            ) : (
              <>
                <div className="chat-header">
                  {selectedChat.name} ({selectedChat.role})
                </div>

                <div className="chat-messages">
                  {messages.length === 0 && (
                    <p className="chat-empty-msg">
                      No messages yet. Start the conversation.
                    </p>
                  )}

                  {messages.map((msg) => (
                    <div
                      key={msg._id}
                      className={`msg ${
                        msg.senderRole === "ngo"
                          ? "msg-sent"
                          : "msg-received"
                      }`}
                    >
                      {msg.message}
                    </div>
                  ))}
                </div>

                <div className="chat-input">
                  <input
                    type="text"
                    placeholder="Type a message..."
                    value={newMessage}
                    onChange={(e) => setNewMessage(e.target.value)}
                    onKeyDown={(e) => e.key === "Enter" && sendMessage()}
                  />
                  <button onClick={sendMessage}>Send</button>
                </div>
              </>
            )}
          </div>
        </div>
      </div>

      {/* DONOR MODAL */}
      {showDonors && (
        <div className="donor-modal">
          <div className="donor-card">
            <h3>Select Donor</h3>

            {donors.length === 0 && (
              <p style={{ color: "#777" }}>No donors found</p>
            )}

            {donors.map((donor) => (
              <div
                key={donor._id}
                className="donor-item"
                onClick={() => startChatWithDonor(donor)}
              >
                {donor.name}
              </div>
            ))}

            <button className="campaign-btn" onClick={() => setShowDonors(false)}>
              Close
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

export default NgoChat;
