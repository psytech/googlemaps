function y = create(lat, long, varargin)
%CREATE Creates a new structure representing a marker
%
%   Signature:      marker = create(lat, long, varargin)
%
%   First arguments are the latitude and the longitude.
%   Optional, named arguments are: 
%       color  - 'black', 'brown', 'green', 'purple', 'yellow', 
%                'blue', 'gray', 'orange', 'red', 'white' or any valid
%                hexadecimal value in the format 0xffffff (no transparency)
%       size   - 'tiny', 'mid', 'small'
%       label  - Single alphanumeric character [A-Z0-9]
%


%% PARSE INPUTS
p = inputParser();

p.addRequired('lat',  @(x) ischar(x) || (isnumeric(x) && isscalar(x)));
p.addRequired('long', @(x) ischar(x) || (isnumeric(x) && isscalar(x)));
p.addParamValue('color', [], @(x) match_color(x));
p.addParamValue('size',  [], @(x) any(strcmp(x, deftype.marker_sizes())));
p.addParamValue('label', [], @(x) match_label(x));

p.parse(lat, long, varargin{:});

%% CREATE STRUCT AND RETURN
y.location = [p.Results.lat p.Results.long];
y.color    = p.Results.color;
y.size     = p.Results.size;
y.label    = p.Results.label;

end


function b = match_label(x)
    b = regexp(x, deftype.marker_label_regexexpr());
end

function b = match_color(x)
    b = any(strcmp(x, deftype.marker_colors())) || ...
        regexp(x, deftype.color_regexexpr(false));    
end



