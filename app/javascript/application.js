// Entrypoint for the esbuild command defined in package.json scripts
// import $ from "jquery/dist/jquery.min.js"
import $ from 'jquery/dist/jquery.min.js'
import "@hotwired/turbo-rails"
import "./controllers"
import "./turbo_streams"
import * as bootstrap from "bootstrap"

window.$ = require("jquery/dist/jquery.min.js")
