import React, {Component} from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

export class Flash extends Component {
 constructor(props) {
  super();
  this.state = {
    show:true,
    type: (!props.alert) ? "advice" : "danger"
  }
 }

 componentDidMount(){
   setTimeout(function() { this.setState({show: false}); }.bind(this), 4000);
 }

 render(){
   const {show, type} = this.state
   return(
       <div className="ContainerFlash">
         {show &&
           <div className={`Flash ${type}`}>
              <p>{this.props.alert || this.props.notice}</p>
           </div>
         }
       </div>
   )
 }
}

document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById("alert-component");

  if (el != null) {
    const alert_txt = el.getAttribute('data-alert');
    const notice_txt = el.getAttribute('data-notice');
    ReactDOM.render(
      <Flash alert={alert_txt} notice={notice_txt} />, el,
    )
  }
})
