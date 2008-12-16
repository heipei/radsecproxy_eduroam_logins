index=0;

function initialize() {
	if (GBrowserIsCompatible()) {
		var map = new GMap2(document.getElementById("map_canvas"));
		map.setCenter(new GLatLng(50.4419, 11.1419), 5);			// start over europe

		map.enableScrollWheelZoom();						// scroll wheel zoom
		map.addControl(new GLargeMapControl());					// controls
		map.addControl(new GScaleControl());					// controls
		map.addControl(new GMapTypeControl());					// controls
		var clusterers = new Array();						// array for country-specific clusters

		var geocoder = new GClientGeocoder();					// object to return search-results
		for (i=0; i < (institutions.length); i++) {				// for all the institutions
			geocoder.getLocations(institutions[i][0], function(latlng) {	// get the location and pass it on
				var place = latlng.Placemark[0];
				var point = new GLatLng(place.Point.coordinates[1],
				place.Point.coordinates[0]);
				var j = index;						// stupid, but javascript wants it that way
				var marker = new GMarker(point, {title: place.address + ": " + institutions[j][2]});		// create new marker
				marker.bindInfoWindowHtml("<h1 style=\"font-family:Arial; background-color: white; border: 0px;\">" 
				+ place.address + "</h2><p align=\"left\">" + institutions[j][1] + ":" + institutions[j][2] + "</p>");

				if (clusterers[institutions[j][3]] == null) {				// if country doesnt already have a clusterer
					clusterers[institutions[j][3]] = new Clusterer(map);		// create a new one
					clusterers[institutions[j][3]].SetMaxVisibleMarkers(5);		// 5 placemarks per country visible at max
					clusterers[institutions[j][3]].SetMinMarkersPerCluster(2);	// 2 placemarks at least are needed to form a cluster
				}
				(clusterers[institutions[j][3]]).AddMarker(marker, place.address + ", " + institutions[j][1] + ": " + institutions[j][2]);
				index++;
			});
		};
		var bounds = map.getBounds();			// get bounds _after_ adding all the placemarks
		map.setZoom(map.getBoundsZoomLevel(bounds));	// zoom
		map.setCenter(bounds.getCenter());		// center
	}
}
