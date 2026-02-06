import express from "express";
import { createOrGetConversation, getDonorsByNgo, getMessages, getMyChats, markAsRead, sendMessage } from "../controllers/conversation.controller.js";

const Chatrouter = express.Router();

Chatrouter.post("/create-or-get", createOrGetConversation);
Chatrouter.post("/my", getMyChats);
Chatrouter.post("/send", sendMessage);
Chatrouter.get("/messages/:conversationId", getMessages);
Chatrouter.get("/donors/by-ngo/:profileId", getDonorsByNgo);
Chatrouter.post("/mark-read", markAsRead);

export default Chatrouter;
