function FlightData = cleanOilSensors(FlightData)
	% Fill outliers
	FlightData = filloutliers(FlightData,"linear","movmedian",100,...
	    "DataVariables",["OilPressure","OilTemperature"]);
end