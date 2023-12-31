function FlightData = importFlightData(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  FLIGHTDATA = IMPORTFILE(FILE) reads data from the first worksheet in
%  the Microsoft Excel spreadsheet file named FILE.  Returns the data as
%  a table.
%
%  FLIGHTDATA = IMPORTFILE(FILE, SHEET) reads from the specified
%  worksheet.
%
%  FLIGHTDATA = IMPORTFILE(FILE, SHEET, DATALINES) reads from the
%  specified worksheet for the specified row interval(s). Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  FlightData = importfile("C:\Demos\LowCode\FlightData.xlsx", "Sheet1", [2, 47313]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 15-Jul-2022 11:03:32

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, Inf];
end

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 13);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = dataLines(1, :);

% Specify column names and types
opts.VariableNames = ["FuelQuantity", "OilPressure", "OilTemperature", "LatitudePosition", "LongitudePosition", "Altitude", "ExhaustTemperature", "FuelFlow", "FanSpeed", "TrueAirSpeed", "WindDirection", "WindSpeed", "WeightOnWheels"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Import the data
FlightData = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = dataLines(idx, :);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    FlightData = [FlightData; tb]; %#ok<AGROW>
end

end