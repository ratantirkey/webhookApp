import { StreamActions } from '@hotwired/turbo'
import Toastify from "toastify-js"

StreamActions.toast = function() {
  // $(document).ready(function(){
  //   let test = $( "body" ).hide()
  //   console.log(test)
  // })
  console.log("toast")
  const message = this.getAttribute("message")
  const position = this.getAttribute("position")
  let toastBackground = this.getAttribute("toastBackground")
  toastBackground = toastBackgroundSet(toastBackground)
  Toastify({
    text: message,
    duration: 3000,
    destination: "",
    close: true,
    gravity: "top",
    position: position,
    stopOnFocus: true,
    offset: {
      x: 50,
      y: 40
    },
    style: toastBackground
  }).showToast()
}

const toastBackgroundSet = toastBackground => {
  switch (toastBackground){
    case "success":
      return toastSuccess()
      break
    case "danger":
      return toastDanger()
      break
    case "info":
      return toastInfo()
      break
    case "warning":
      return toastWarning()
      break
    default:
      return toastDefault()
      break
  }
}

const toastDefault = () => {
  let toastDefault = {}
  toastDefault['background'] = "linear-gradient(to right, #00b09b, #96c93d)"
  return toastDefault
}

const toastSuccess = () => {
  let success = {}
  success['background'] = "#d1e7dd"
  success['color'] = "#0f5132"
  success['borderColor'] = "#badbcc"
  return success
}

const toastInfo = () => {
  let info = {}
  info['background'] = "#cff4fc"
  info['color'] = "#055160"
  info['borderColor'] = "#b6effb"
  return info
}

const toastDanger = () => {
  let danger = {}
  danger['background'] = "#f8d7da"
  danger['color'] = "#842029"
  danger['borderColor'] = "#f5c2c7"
  return danger
}

const toastWarning = () => {
  let warning = {}
  warning['background'] = "#fff3cd"
  warning['color'] = "#664d03"
  warning['borderColor'] = "#ffecb5"
  return warning
}
