function tracks = initializeTracks()
        % Create an empty array of tracks
        tracks = struct(...
            'id', {}, ...
            'color', {}, ...
            'bboxes', {}, ...
            'scores', {}, ...
            'kalmanFilter', {}, ...
            'predPosition', {});
    end