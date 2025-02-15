import { Application } from "@hotwired/stimulus"
import ScrollController from "./controllers/scroll_controller"

const application = Application.start()

application.debug = false
window.Stimulus   = application
application.register("scroll", ScrollController);

const context = require.context("./controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

export { application }

