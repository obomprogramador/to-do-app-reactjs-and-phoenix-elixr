import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.jsx'
import './index.css'
import { ToDoProvider } from './global-contexts/MobxGSToDoContext'
import { AuthenticateProvider } from './global-contexts/MobxGSAuthenticateContext'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <AuthenticateProvider>
      <ToDoProvider>
        <App />
      </ToDoProvider>
    </AuthenticateProvider>
  </React.StrictMode>
)
