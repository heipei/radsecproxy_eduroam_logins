index=0;

function initialize() {
	if (GBrowserIsCompatible()) {
		var map = new GMap2(document.getElementById("map_canvas"));
		map.setCenter(new GLatLng(50.4419, 11.1419), 4);			// start over europe

		map.enableScrollWheelZoom();						// scroll wheel zoom
		map.addControl(new GLargeMapControl());					// controls
		map.addControl(new GScaleControl());					// controls
		map.addControl(new GMapTypeControl());					// controls
		//bounds = new GLatLngBounds();						// get bounds _after_ adding all the placemarks
		var clusterers = new Array();						// array for country-specific clusters

		for (i=0; i < (institutions.length); i++) {				// for all the institutions
				var j = index;						// stupid, but javascript wants it that way
				var point = new GLatLng(institutions[j][4], institutions[j][5]);
				//bounds.extend(point);
				var marker = new GMarker(point, {title: institutions[j][0] + ": " + institutions[j][2]});		// create new marker
				marker.bindInfoWindowHtml("<h1 style=\"font-family:Arial; background-color: white; border: 0px;\">" 
				+ institutions[j][0] + "</h2><p align=\"left\">" + institutions[j][1] + ":" + institutions[j][2] + "</p>");

				if (clusterers[institutions[j][3]] == null) {				// if country doesnt already have a clusterer
					clusterers[institutions[j][3]] = new Clusterer(map);		// create a new one
					clusterers[institutions[j][3]].SetMaxVisibleMarkers(5);		// 5 placemarks per country visible at max
					clusterers[institutions[j][3]].SetMinMarkersPerCluster(2);	// 2 placemarks at least are needed to form a cluster
				}
				(clusterers[institutions[j][3]]).AddMarker(marker, institutions[j][0] + ", " + institutions[j][1] + ": " + institutions[j][2]);
				index++;
		};
		//map.setZoom(map.getBoundsZoomLevel(bounds));	// zoom
		//map.setCenter(bounds.getCenter());		// center
	}
}
