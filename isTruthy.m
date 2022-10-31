function out = isTruthy(in)
% Check if the input is truthy

    % Check input type
    % All the basic MATLAB Types are here:
    % https://mathworks.com/help/matlab/data-types.html

    % NOTE: <boolean>
    if isequal(in, false) || isequal(in, true)
        out = in;
        return
    end
    if islogical(in)
        out = all(in(:));
        return
    end

    % NOTE: empty (number | char) array | empty cell | empty table
    % | empty categorical | empty timetable | empty containners.Map
    % | empty dataset
    if isempty(in)
        out = false;
        return
    end

    % NOTE: <non-empty table>
    if istable(in)
        out = true;
        return
    end

    % NOTE: <non-empty cell>
    if iscell(in)
        if iscellstr(in)
            in = string(in);
        else
            out = true;
            return
        end
    end

    % NOTE: <non-empty char-array>
    if ischar(in)
        out = true;
        return
    end

    % NOTE: <string>
    if isstring(in)
        out = strlength(in) > 0;
        return
    end

    % NOTE: <struct>
    if isstruct(in)
        out = ~isempty(fieldnames(in));
        return
    end

    % NOTE: <graphics handle>
    if ishghandle(in)
        % NOTE: `isgraphics` tests validity of graphics handle. 
        out = true;
        return
    end

    % NOTE: <enum>
    if isenum(in)
        out = true;
        return
    end

    % NOTE: <duration>
    if isduration(in)
        % NOTE: Calling `duration` with no parameters instantiates 
        %       the "00:00:00" duration. 
        out = all(in ~= 0);
        return
    end

    % NOTE: <non-empty timetable>
    if istimetable(in)
        out = true;
        return
    end

    % NOTE: <timeseries>
    if isa(in, 'timeseries')
        % NOTE: <empty timeseries> has 
        %       non-empty `TimeInfo` and `DataInfo` properties.
        out = ~(timeseries == in);
        return
    end

    % NOTE: <datetime>
    if isdatetime(in)
        % NOTE: `datetime` is identical to `datetime('now')`. 
        out = ~any(in.isnat());
        return
    end

    % NOTE: nan
    if isnumeric(in) && any(isnan(in(:)))
        out = false;
        return
    end

    % NOTE: <function handle>
    if isa(in, 'function_handle')
        out = true;
        return
    end

    % NOTE: <number array> | <calendar> | <unknown type>
    out = all(logical(in(:)));
end
