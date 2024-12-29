import React, { useState, useEffect } from "react";

function App() {
    const [status, setStatus] = useState("");
    const [message, setMessage] = useState("");
    const [response, setResponse] = useState("");

    // Fetch health status on load
    useEffect(() => {
        fetch("http://127.0.0.1:5000/health")
            .then((response) => response.json())
            .then((data) => setStatus(data.status))
            .catch((error) => console.error("Error fetching health:", error)); // Missing closing parenthesis was here
    }, []);

    // Handle form submission for chat
    const handleSubmit = (e) => {
        e.preventDefault();

        fetch("http://127.0.0.1:5000/chat", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ message }),
        })
            .then((response) => response.json())
            .then((data) => setResponse(data.response))
            .catch((error) => console.error("Error sending message:", error));
    };

    return (
        <div>
            <h1>Backend Status: {status}</h1>

            <form onSubmit={handleSubmit}>
                <label>
                    Enter your message:
                    <input
                        type="text"
                        value={message}
                        onChange={(e) => setMessage(e.target.value)}
                    />
                </label>
                <button type="submit">Send</button>
            </form>

            {response && <p>Response from backend: {response}</p>}
        </div>
    );
}

export default App;
