import { useEffect } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'

import { useMobxGSToDoStore } from './global-contexts/MobxGSToDoContext'
import { useMobxGSAuthenticateStore } from './global-contexts/MobxGSAuthenticateContext'

import OrganismManageToDos from './atomic-design/organisms/organism_manage_to_dos'

function App() {  
  const MobxGSToDoStore = useMobxGSToDoStore()
  const MobxGSAuthenticateStore = useMobxGSAuthenticateStore()
  
  useEffect(() => {
    async function SetUserCredentials() {
      await MobxGSAuthenticateStore.getAccess(
        import.meta.env.VITE_AUTH_TO_DOS_EMAIL,
        import.meta.env.VITE_AUTH_TO_DOS_PASS
      )
    }

    SetUserCredentials().then(() => {
      const auth_token_now = MobxGSAuthenticateStore.getCurAuthToken()
      MobxGSToDoStore.listAllToDos(auth_token_now)
    })
  }, [])
  
  return (
    <>
      <div>
        <a href="https://vitejs.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Vite + React</h1>

      <OrganismManageToDos />

      <p className="read-the-docs">
        Click on the Vite and React logos to learn more
      </p>
    </>
  )
}

export default App
