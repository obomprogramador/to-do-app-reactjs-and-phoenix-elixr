import axios from "axios"

export function MobxGSAuthenticateManager() {
  return {
    auth_token: undefined,
    is_token_valid: false,
    
    async getAccess(email, password) { 
      await axios.post(
        `${import.meta.env.VITE_URI_TO_DOS}/users/authenticate`,
        {"email": email, "virtual_password": password}
      )
      .then(resp => {
        this.auth_token = resp.data.bearer
        this.is_token_valid = true
      })
    },
    
    restartAuth() { 
      this.is_token_valid = false
    },

    getCurAuthToken() {
      return this.auth_token
    }
  }
}