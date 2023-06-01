import React, {useState} from 'react';
import './App.css';

function customFetch(url, options) {
    const modifiedOptions = {
        ...options,
        mode: 'cors',
        headers: {
            ...options.headers,
            'Access-Control-Request-Method': options.method,
            'Access-Control-Request-Headers': options.headers ? Object.keys(options.headers).join(',') : '',
        },
    };

    return fetch(url, modifiedOptions);
}

function App() {
    const [inputValue, setInputValue] = useState('');
    const [response, setResponse] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const [error, setError] = useState('');

    const handleSubmit = async (event) => {
        event.preventDefault();
        setIsLoading(true);
        setError('');

        try {
            const response = await customFetch('http://localhost:8200/ask', {
                method: 'POST',
                headers: {
                    'Content-Type': 'text/plain',
                },
                body: inputValue,
                mode: 'cors',
                changeOrigin: true,
                secure: false,
            });

            if (!response.ok) {
                throw new Error('Request failed');
            }

            const responseData = await response.text();
            setResponse(responseData);

        } catch (error) {
            setError('An error occurred. Please try again.');
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <div className="App">
            <header>
                <h1>FlyGPT Web Application</h1>
                <p>Last Updated: <span style={{fontWeight: "bold"}}>May 20th, 2023</span></p>
            </header>
            <main>
                <form onSubmit={handleSubmit}>
                    <textarea
                        value={inputValue}
                        onChange={(event) => setInputValue(event.target.value)}
                        placeholder="Enter your message..."
                        style={{height: '100px', width: '400px', resize: 'vertical'}}

                    ></textarea>

                    <button type="submit" disabled={isLoading}>
                        {isLoading ? 'Sending...' : 'Send'}
                    </button>
                </form>
                {isLoading && <div className="loader"></div>}
                {error && (
                    <div className="error-container">
                        <p>{error}</p>
                    </div>
                )}
                {response && (
                    <div className="response-container">
                        <p className="response-text">{response}</p>
                    </div>
                )}
            </main>
        </div>
    );
}

export default App;
