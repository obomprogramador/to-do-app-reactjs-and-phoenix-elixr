import React from 'react'
import { MobxGSToDoManager } from '../mobx-global-state-manager/MobxGSToDo'
import { useLocalObservable } from 'mobx-react'
import PropTypes from 'prop-types'

const ToDoContext = React.createContext(null)

export const ToDoProvider = ({ children }) => {
  const MobxGSToDoStore = useLocalObservable(MobxGSToDoManager)
  return <ToDoContext.Provider value={ MobxGSToDoStore }>
    { children }
  </ToDoContext.Provider>
}

ToDoProvider.propTypes = {
  children: PropTypes.node.isRequired,
}

export const useMobxGSToDoStore = () => React.useContext(ToDoContext)