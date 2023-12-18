import axios from "axios";

export const API = axios.create({
  baseURL: "backend_url",

  headers: {
    "Content-Type": "application/json"
  },
  withCredentials: true
});

export default API;
