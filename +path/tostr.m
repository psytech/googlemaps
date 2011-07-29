function y = tostr(x)
%TOSTR Summary of this function goes here
%   Detailed explanation goes here

%% CHECK INPUT
if ~path.ispath(x)
    error('Input does not seem to be a valid path');
end

%% STRING CONCATENATION
y = '';

% COLOR
if ~isempty(x.color)
    y = sprintf('color:%s|', x.color);
end

% WEIGHT
if~isempty(x.weight)
    y = sprintf('%sweight:%s|', y, num2str(x.weight));
end

% FILLCOLOR
if ~isempty(x.fillcolor)
    y = sprintf('%sfillcolor:%s|',y, x.fillcolor);
end

% LOCATIONS
for i=1:size(x.locations, 1)
    y = sprintf('%s%s,%s|', y, num2str(x.locations(i,1)), ...
                               num2str(x.locations(i,2)));
end

y = y(1:end-1);

end

