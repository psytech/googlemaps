%% EXAMPLE
% Place marker in Cologne and Wachtberg
m1 = marker.create(50.949343, 6.961899, 'label', 'C');
m2 = marker.create(50.627033, 7.128754, 'color', '0x24fe53', 'label', 'W');

% Path
p = path.create([50.949343 50.627033 50.345673 50.949343], ...   % lat
                [6.961899 7.128754 7.043562 6.961899], ...       % long
                'weight', 6, 'color', 'blue', 'fillcolor', '0xFE120433');

% Image center (optional, since there are at least two markers)            
center = [50.949343 6.961899];

% Image size in pixels
size = [640, 640];

% Get map and display
img = googlemaps('size', size, 'markers', [m1 m2], 'maptype', 'satellite', 'paths', p);

figure, imagesc(img.data);