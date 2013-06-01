Setup
==============================

 1. Download and install [ElasticSearch](http://www.elasticsearch.org/)
 2. Install Ruby 1.9.3
 3. Install Rails
   * Be sure that Rails is not trying to use Ruby 1.8, it will not work
 3. Install Bundle
 4. Run `bundle`
   * May need `sudo apt-get install libpq-dev`
   * May need `sudo apt-get install libsqlite3-dev`


 5. Index GeoData `rake environment tire:import CLASS='Stop' FORCE=true`


MetroTransit API Documentation
==============================

There are two ways to get real-time arrival data. One can use either the global numeric **StopID** via `http://svc.metrotransit.org/NexTrip/{STOPID}` or the route's local alphanumeric **StopID** via `http://svc.metrotransit.org/NexTrip/{ROUTE}/{DIRECTION}/{STOP}`.

Real-time Arrival Data for a Stop
---------------------------------

http://svc.metrotransit.org/NexTrip/{STOPID}

**StopID** is a numeric identifier available from the GTFS information in **data/stops.txt**

Example call:

    http://svc.metrotransit.org/NexTrip/17976?format=json

Example output:

    [
        {
            "DepartureTime": "/Date(1370107440000-0500)/",
            "DepartureText": "Due",
            "Description": "24St-Uptown / Lake-France",
            "VehicleLongitude": -93.26514,
            "RouteDirection": "WESTBOUND",
            "Route": "17",
            "BlockNumber": 1180,
            "Terminal": "B",
            "Actual": true,
            "Gate": "",
            "VehicleLatitude": 44.9810355,
            "VehicleHeading": 0
        },
        {
          ....
          ....
        },
        ....
    ]

List of Routes Names, Descriptions, and Providers
-------------------------------------------------
http://svc.metrotransit.org/NexTrip/Routes

Example call:

    http://svc.metrotransit.org/NexTrip/Routes?format=json

Example output:

    [
        {
            "Route": "2",
            "ProviderID": "8",
            "Description": "2 - Franklin Av - Riverside Av - U of M - 8th St SE"
        },
        {
            "Route": "3",
            "ProviderID": "8",
            "Description": "3 - U of M - Como Av - Energy Park Dr - Maryland Av"
        },
        {
            "Route": "4",
            "ProviderID": "8",
            "Description": "4 - New Brighton - Johnson St - Bryant Av - Southtown"
        }
    ]

List of Directions for a Route
------------------------------
http://svc.metrotransit.org/NexTrip/Directions/{ROUTE}

Example call:

    http://svc.metrotransit.org/NexTrip/Directions/16?format=json

Example output:

    [
        {
            "Text": "EASTBOUND",
            "Value": "2"
        },
        {
            "Text": "WESTBOUND",
            "Value": "3"
        }
    ]

List of Providers
-----------------

http://svc.metrotransit.org/NexTrip/Providers

Example call:

    http://svc.metrotransit.org/NexTrip/Providers?format=json

Example output:

  [
      {
          "Text": "University of Minnesota",
          "Value": "1"
      },
      {
          "Text": "Airport (MAC)",
          "Value": "2"
      },
      {
          "Text": "Other",
          "Value": "3"
      },
      {
          "Text": "Prior Lake",
          "Value": "4"
      },
      {
          "Text": "Scott County",
          "Value": "5"
      }
  ]

List of Stops on a Route
------------------------

http://svc.metrotransit.org/NexTrip/Stops/{ROUTE}/{DIRECTION}

Example call (East bound stops):

    http://svc.metrotransit.org/NexTrip/Stops/16/2?format=json

Example output:

    [
        {
            "Text": "Ramp B/5th St  Transit Center",
            "Value": "5GAR"
        },
        {
            "Text": "4th St S  and Nicollet Mall",
            "Value": "4NIC"
        },
        {
            "Text": "Anderson Hall (U of M)",
            "Value": "ANHA"
        },
        {
            "Text": "Jones Hall and Eddy Hall (U of M)",
            "Value": "JOED"
        },
        {
            "Text": "University Ave and Ontario St",
            "Value": "OAUN"
        }
    ]

Information About A Stop
-------------------------

http://svc.metrotransit.org/NexTrip/{ROUTE}/{DIRECTION}/{STOP}

Example call (East bound stops):

    http://svc.metrotransit.org/NexTrip/16/2/ANHA

Example output:

    [
        {
            "DepartureTime": "/Date(1370109060000-0500)/",
            "DepartureText": "Due",
            "Description": "Univ Av / St Paul",
            "VehicleLongitude": -93.249402,
            "RouteDirection": "EASTBOUND",
            "Route": "16",
            "BlockNumber": 1172,
            "Terminal": "",
            "Actual": true,
            "Gate": "",
            "VehicleLatitude": 44.9717209,
            "VehicleHeading": 0
        },
        {
            "DepartureTime": "/Date(1370109420000-0500)/",
            "DepartureText": "7 Min",
            "Description": "Univ Av / St Paul",
            "VehicleLongitude": -93.2716287,
            "RouteDirection": "EASTBOUND",
            "Route": "16",
            "BlockNumber": 1168,
            "Terminal": "",
            "Actual": true,
            "Gate": "",
            "VehicleLatitude": 44.9804872,
            "VehicleHeading": 0
        },
        {
            "DepartureTime": "/Date(1370109960000-0500)/",
            "DepartureText": "16 Min",
            "Description": "Univ Av / St Paul",
            "VehicleLongitude": -93.271077,
            "RouteDirection": "EASTBOUND",
            "Route": "16",
            "BlockNumber": 1165,
            "Terminal": "",
            "Actual": true,
            "Gate": "",
            "VehicleLatitude": 44.9806579,
            "VehicleHeading": 0
        },
        {
            "DepartureTime": "/Date(1370110560000-0500)/",
            "DepartureText": "1:16",
            "Description": "Univ Av / St Paul",
            "VehicleLongitude": 0,
            "RouteDirection": "EASTBOUND",
            "Route": "16",
            "BlockNumber": 1169,
            "Terminal": "",
            "Actual": false,
            "Gate": "",
            "VehicleLatitude": 0,
            "VehicleHeading": 0
        },
        {
            "DepartureTime": "/Date(1370111160000-0500)/",
            "DepartureText": "1:26",
            "Description": "Univ Av / St Paul",
            "VehicleLongitude": 0,
            "RouteDirection": "EASTBOUND",
            "Route": "16",
            "BlockNumber": 1164,
            "Terminal": "",
            "Actual": false,
            "Gate": "",
            "VehicleLatitude": 0,
            "VehicleHeading": 0
        }
    ]
