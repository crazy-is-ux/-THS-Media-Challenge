/* THS Statistik: SUPABASE_URL und SUPABASE_ANON_KEY nach Einrichtung eintragen. Niemals service_role verwenden. */
window.THS_CONFIG={url:"",anonKey:""};
window.THSStats={
 async submit(quiz,answers){
  const c=window.THS_CONFIG;
  if(!c.url||!c.anonKey)return false;
  try{
   const r=await fetch(c.url.replace(/\/$/,"")+"/rest/v1/quiz_results",{
    method:"POST",headers:{"apikey":c.anonKey,"Authorization":"Bearer "+c.anonKey,"Content-Type":"application/json","Prefer":"return=minimal"},
    body:JSON.stringify({quiz,answers})
   });return r.ok
  }catch(e){return false}
 },
 async summary(){
  const c=window.THS_CONFIG;if(!c.url||!c.anonKey)throw Error("Datenbank noch nicht verbunden");
  const r=await fetch(c.url.replace(/\/$/,"")+"/rest/v1/rpc/quiz_summary",{
   method:"POST",headers:{"apikey":c.anonKey,"Authorization":"Bearer "+c.anonKey,"Content-Type":"application/json"},body:"{}"
  });if(!r.ok)throw Error("Statistik konnte nicht geladen werden ("+r.status+")");return r.json()
 }
};