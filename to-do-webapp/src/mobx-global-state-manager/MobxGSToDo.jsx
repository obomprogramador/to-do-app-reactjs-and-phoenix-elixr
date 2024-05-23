import axios from "axios"

export function MobxGSToDoManager() {
  return {
    to_do_list: [],
    token_still_valid: false,

    listAllToDos(token) { 
      axios.get(`${import.meta.env.VITE_URI_TO_DOS}/to_dos`, {
        headers: {
          "Authorization": `Bearer ${token}`
        }
      }).then(resp => {
        this.to_do_list = resp.data.data
      })
    },

    createToDo(text, status, token) {
      const params = {
        "description": text,
        "status": status
      }

      axios.post(`${import.meta.env.VITE_URI_TO_DOS}/to_dos`, params, {
        headers: {
          "Authorization": `Bearer ${token}`
        }
      }).then(resp => {
        if (resp.status === 201) {
          this.listAllToDos(token)
        }
      })
    },

    updateToDo(id, status, token) {
      const params = {"to_do_list": [{
        "id": id,
        "status": status
      }]}

      axios.post(`${import.meta.env.VITE_URI_TO_DOS}/to_dos/update`, params, {
        headers: {
          "Authorization": `Bearer ${token}`
        }
      }).then(resp => {
        if (resp.status === 200) {
          this.listAllToDos(token)
        }
      })
    },

    deleteToDo(id, token) {
      axios.delete(`${import.meta.env.VITE_URI_TO_DOS}/to_dos/${id}`, {
        headers: {
          "Authorization": `Bearer ${token}`
        }
      }).then(resp => {
        if (resp.status === 200) {
          this.listAllToDos(token)
        }
      })
    },

    getToDoList() {
      return this.to_do_list
    }
  }
}