import { useState, useEffect } from 'react'

import { useMobxGSToDoStore } from '../../global-contexts/MobxGSToDoContext'
import { useMobxGSAuthenticateStore } from '../../global-contexts/MobxGSAuthenticateContext'
import { observer } from 'mobx-react'

const MoleculeToDoInput = observer(() => {
  const [auth_token, setAuthToken] = useState(undefined)
  const [to_do_text, setToDoText] = useState("")
  const MobxGSToDoStore = useMobxGSToDoStore()
  const MobxGSAuthenticateStore = useMobxGSAuthenticateStore()

  useEffect(() => {
    setAuthToken(MobxGSAuthenticateStore.getCurAuthToken())
  }, [MobxGSAuthenticateStore.auth_token])

  return (
    <>
      <div className="card">
        <div style={{display: "flax", gap: 50}}>
          <input
            type="text"
            id="toDoInputTextGH321DGFH654G"
            onChange={event => setToDoText(event.target.value)}
          />
          
          <button 
            onClick={() => {
              to_do_text.length > 0 && MobxGSToDoStore.createToDo(to_do_text, true, auth_token)
              document.getElementById("toDoInputTextGH321DGFH654G").value = ""
            }}
          >
            New To Do
          </button>
        </div>
        <p>
          Edit <code>src/App.jsx</code> and save to test HMR
        </p>
      </div>
    </>
  )
})

export default MoleculeToDoInput