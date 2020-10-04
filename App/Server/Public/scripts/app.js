var localBra = {};
var positionMyLocation = {};
async function postDB(locate,name) {
    let user = {
        altitude: 1,
        username: 'AR Object',
        positionID: parseInt(name),
        locate : locate//[{"lat":43.4,"lot":34.3},{"lat":43.4,"lot":34.3}]
    };
    console.log(locate);
  
      let response =  await fetch('https://building-gis.herokuapp.com/users/', {
        method: 'POST',
        headers: {
        'Content-Type': 'application/json;charset=utf-8'
        },
        body: JSON.stringify(user)
     });
  
      let result =  await response.json();
    alert(result.username);
}
//
async function getDB() {
    let url = 'https://building-gis.herokuapp.com/users/';
    let response = await fetch(url);
    let commits = await response.json(); // читаем ответ в формате JSON
    alert(commits[0].username);
}
//
async function getLocation() {
    let url = 'https://building-gis.herokuapp.com/tracking/';
    let response = await fetch(url);
    let locationBrazil = await response.json(); // читаем ответ в формате JSON
    //let last_i = locationBrazil.length;
    //let posLoc = locationBrazil[last_i - 1]
    //console.log(locationBrazil[last_i - 1]);
    localBra = {lat:locationBrazil.lat, lng:locationBrazil.lon}
    console.log(localBra);
}

    function success(position) {
      const mapLink = document.querySelector('#map-link');
      const latitude  = position.coords.latitude;
      const longitude = position.coords.longitude;
      const accuracy = position.coords.accuracy;
      positionMyLocation = {lat : latitude,lng : longitude}
      console.log(positionMyLocation)
      mapLink.href = `https://www.openstreetmap.org/#map=18/${latitude}/${longitude}`;
    }
    
  function getLocate() {
    navigator.geolocation.getCurrentPosition(success);
  }
  
    //if (!navigator.geolocation) {
     // status.textContent = 'Geolocation is not supported by your browser';
   // } else {
     // status.textContent = 'Locating…';
    //  navigator.geolocation.getCurrentPosition(success, error);
    //} 
  
//

  //
  function onTap(evt) {
    // calculate infobubble position from the cursor screen coordinates
    let position = map.screenToGeo(
      evt.currentPointer.viewportX,
      evt.currentPointer.viewportY
    );
    
 
    // read the properties associated with the map feature that triggered the event
    let props = evt.target.getData().properties;
    drawCircle(position);
  }
  function drawCircle(position) {
    addCircleToMap(position);
}
