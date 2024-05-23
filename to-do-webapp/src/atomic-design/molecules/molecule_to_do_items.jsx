import { useState, useEffect } from 'react'

import { useMobxGSToDoStore } from '../../global-contexts/MobxGSToDoContext'
import { useMobxGSAuthenticateStore } from '../../global-contexts/MobxGSAuthenticateContext'

import { Observer, observer } from 'mobx-react'

const MoleculeToDoItems = observer(() => {
  const [auth_token, setAuthToken] = useState(undefined)
  const MobxGSToDoStore = useMobxGSToDoStore()
  const MobxGSAuthenticateStore = useMobxGSAuthenticateStore()

  useEffect(() => {
    setAuthToken(MobxGSAuthenticateStore.getCurAuthToken())
  }, [MobxGSAuthenticateStore.auth_token])

  return (
    <>
      <div className="card">
        <ul style={{listStyle: "none"}}>
          <Observer>
            {() => {
              const to_do_list = JSON.parse(JSON.stringify(MobxGSToDoStore.getToDoList()))
              return to_do_list.sort((a, b) => b.status - a.status).map((to_do, index) => {
                return(
                  <li key={index} style={{display: "flex", gap: 150}}>
                    <div style={{display: "flex"}}>
                      <input
                        type="checkbox"
                        defaultChecked={!to_do.status}
                        name={to_do.id}
                        onChange={event =>
                          MobxGSToDoStore.updateToDo(
                            event.target.name,
                            !event.target.checked,
                            auth_token
                          )
                        }
                      />
                      <p style={{textDecoration: `${to_do.status && "none" || "line-through"}`}}>
                        {to_do.description}
                      </p>
                    </div>
                    <button
                      data-todo_id={to_do.id}
                      onClick={event =>
                        MobxGSToDoStore.deleteToDo(
                          event.target.getAttribute("data-todo_id"),
                          auth_token
                        )
                      }
                    >
                      Delete
                    </button>
                  </li>
                )
              })
            }}
          </Observer>
        </ul>
      </div>
    </>
  )
})

export default MoleculeToDoItems