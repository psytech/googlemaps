function y = tostr(x)
%TOSTR Converts marker x to string for use in url
%
%   str = tostr(marker)
%

%% CHECK INPUT
if ~marker.ismarker(x)
    error('Input does not seem to be a valid marker');
end

%% STRING CONCATENATION
y = '';

if ~isempty(x.color)
    y = sprintf('color:%s|', x.color);
end

if~isempty(x.size)
    y = sprintf('%ssize:%s|', y, x.size);
end

if ~isempty(x.label)
    y = sprintf('%slabel:%s|',y, x.label);
end

y = sprintf('%s%s,%s', y, num2str(x.location(1)), num2str(x.location(2)));


end

