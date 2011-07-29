function img = googlemaps(varargin)
%GOOGLEMAPS Get map from google maps
%   This function works with version 2.0 of the Google Static Map API. 
%   
%   Signature:              map = googlemaps(varargin)
%
%   Named arguments:
%       center (required) - Center position in [lat long]
%                           Optional if two or more markers are specified.
%       zoom (required)   - Integer in interval [0,21]
%                           Optional if two or more markers are specified.
%       size (required)   - Image size in pixels (max: 640 x 640)      
%       format            - 'gif', 'jpg', 'png', 'png32', 'jpg-baseline'
%       maptype           - 'roadmap', 'satellite', 'hybrid', 'terrain'
%       markers           - One or more markers (type: help marker.create)
%       paths             - One or more pathes (type: help path.create)
%
%   Reference:
%   http://code.google.com/apis/maps/documentation/staticmaps/
%   
    
%% PARSE INPUTS
p = inputParser();
 
% LOCATION PARAMETERS
p.addParamValue('center',  [], @(x) ischar(x) || (isnumeric(x) && isvector(x) && (numel(x) == 2)));
p.addParamValue('zoom',    [], @(x) (0 <= x) && (x <= 21));

% MAP PARAMETERS
p.addParamValue('size',    [],          @(x) isvector(x) && all(x > 0) && (numel(x) == 2));
p.addParamValue('format',  'png32',     @(x) any(strcmp(x, deftype.map_formats())));
p.addParamValue('maptype', 'satellite', @(x) any(strcmp(x, deftype.map_types())));

% FEATURE PARAMETERS
p.addParamValue('markers', [], @(x) all(marker.ismarker(x)));
p.addParamValue('paths', [], @(x) all(path.ispath(x)));

p.parse(varargin{:});


%% REQUIRED ARGUMENTS
if numel(p.Results.markers) < 2
    force_existence(p.Results, 'center');
    force_existence(p.Results, 'zoom');
end

force_existence(p.Results, 'size');


%% CREATE PARAMETER STRINGS
% CENTER
if ~isempty(p.Results.center) && isnumeric(p.Results.center)
    strcenter = [num2str(p.Results.center(1)) ',' num2str(p.Results.center(2))];
else
    strcenter = p.Results.center;
end

% ZOOM
if ~isempty(p.Results.zoom)
    strzoom = num2str(int64(p.Results.zoom));
end

% SIZE
strsize = [num2str(p.Results.size(1)) 'x' num2str(p.Results.size(2))];

% others
strformat = p.Results.format;
strmaptype = p.Results.maptype;


%% FINAL URL
url = [deftype.url_base() ...       
       'size=' strsize '&' ...
       'format=' strformat '&' ...
       'maptype=' strmaptype '&' ...
       'sensor=false'];

if ~isempty(p.Results.center)
    url = [url '&center=' strcenter];
end
   
if ~isempty(p.Results.zoom)
    url = [url '&zoom=' strzoom];
end

%% MARKERS
if ~isempty(p.Results.markers)
    strmarkers = arrayfun(@(x) marker.tostr(x), ...
                          p.Results.markers, ...
                          'UniformOutput', false);
    
    for i=1:numel(strmarkers)
        url = [url '&markers=' strmarkers{i}];
    end
end

%% PATHS
if ~isempty(p.Results.paths)
    strpaths = arrayfun(@(x) path.tostr(x), ...
                        p.Results.paths, ...
                        'UniformOutput', false);
                    
    for i=1:numel(strpaths)
        url = [url '&path=' strpaths{i}];
    end
end


%% VALIDATE URL LENGTH
if numel(url) > deftype.max_url_length()
    error('URL is too long! Please remove some items!');
end
   
%% FETCH DATA AND RETURN
img.data    = imread(url);
img.center  = p.Results.center;
img.size    = p.Results.size;
img.zoom    = p.Results.zoom;
img.markers = p.Results.markers;
img.url     = url;
end




function force_existence(x, name)
    if ~ischar(name)
        error('String expected');
    end
    
    if isempty(getfield(x, name))
        error(['Required argument: ' name]);
    end
end



