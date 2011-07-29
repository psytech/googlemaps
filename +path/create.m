function y = create(lats, longs, varargin)
%CREATE 


%% PARSE INPUT
p = inputParser();
p.addRequired('lat',  @(x) isnumeric(x) && isvector(x));
p.addRequired('long', @(x) isnumeric(x) && isvector(x));
p.addParamValue('weight',    [], @(x) isnumeric(x) && x > 0);
p.addParamValue('color',     [], @(x) match_color(x));
p.addParamValue('fillcolor', [], @(x) match_color(x));

p.parse(lats, longs, varargin{:});

%% ERROR CHECKING
N = numel(p.Results.lat);
M = numel(p.Results.long);

if N~=M
    error('lat and long have different number of values');
end

%% CREATE STRUCT AND RETURN
y.weight    = int64(p.Results.weight);
y.color     = p.Results.color;
y.fillcolor = p.Results.fillcolor;
y.locations = [reshape(p.Results.lat, N, 1) reshape(p.Results.long, N, 1)];

end

function b = match_color(x)
    b = any(strcmp(x, deftype.path_colors())) || ...
        regexp(x, deftype.color_regexexpr(true));
end