"use strict";var l=Object.defineProperty;var m=Object.getOwnPropertyDescriptor;var u=Object.getOwnPropertyNames;var d=Object.prototype.hasOwnProperty;var p=(e,t)=>{for(var i in t)l(e,i,{get:t[i],enumerable:!0})},P=(e,t,i,o)=>{if(t&&typeof t=="object"||typeof t=="function")for(let n of u(t))!d.call(e,n)&&n!==i&&l(e,n,{get:()=>t[n],enumerable:!(o=m(t,n))||o.enumerable});return e};var w=e=>P(l({},"__esModule",{value:!0}),e);var y={};p(y,{default:()=>f});module.exports=w(y);var h=require("child_process"),r=require("@raycast/api"),g=require("node:os");async function c(e,t){let i=(0,r.getPreferenceValues)(),o=i.nightlightPath&&i.nightlightPath.length>0?i.nightlightPath:(0,g.cpus)()[0].model.includes("Apple")?"/opt/homebrew/bin/nightlight":"/usr/local/bin/nightlight";try{(0,h.execSync)(`${o} ${e}`),await(0,r.showToast)({style:r.Toast.Style.Success,title:t})}catch(n){let a="stderr"in n?n.stderr:"unknown error";await(0,r.showToast)({style:r.Toast.Style.Failure,title:"Failed",message:a.includes("nightlight: command not found")?"Please install nightlight.":a})}}var s=require("@raycast/api");async function f(){(0,s.getPreferenceValues)().closeWindow&&await(0,s.closeMainWindow)(),await c("off","Turned night shift off")}