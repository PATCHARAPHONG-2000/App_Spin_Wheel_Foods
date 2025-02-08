// firebase.js
import { initializeApp } from "https://www.gstatic.com/firebasejs/9.15.0/firebase-app.js";
import { getFirestore } from "https://www.gstatic.com/firebasejs/9.15.0/firebase-firestore.js";
import { getStorage } from "https://www.gstatic.com/firebasejs/9.15.0/firebase-storage.js";

const firebaseConfig = {
    apiKey: "AIzaSyDyIJaX1XjKFhHR-QYfmnJ7uiIryJefQ0Y",
    authDomain: "spinning-foods.firebaseapp.com",
    projectId: "spinning-foods",
    storageBucket: "spinning-foods.appspot.com",
    messagingSenderId: "568427518989",
    appId: "1:568427518989:web:6c69ae77a3f6377d754944",
    measurementId: "G-HF7MX4Z01P"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Initialize Firestore and Storage
const db = getFirestore(app);
const storage = getStorage(app);

export { db, storage };
