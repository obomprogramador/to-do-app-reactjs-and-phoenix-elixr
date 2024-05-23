import React from 'react'
import { MobxGSAuthenticateManager } from '../mobx-global-state-manager/MobxGSAuthenticate'
import { useLocalObservable } from 'mobx-react'
import PropTypes from 'prop-types'

const AuthenticateContext = React.createContext(null)

export const AuthenticateProvider = ({ children }) => {
  const MobxGSAuthenticateStore = useLocalObservable(MobxGSAuthenticateManager)
  return <AuthenticateContext.Provider value={ MobxGSAuthenticateStore }>
    { children }
  </AuthenticateContext.Provider>
}

AuthenticateProvider.propTypes = {
  children: PropTypes.node.isRequired,
}

export const useMobxGSAuthenticateStore = () => React.useContext(AuthenticateContext)