% SETUP Configure MATLAB-Truthiness exposure of shorthand `tr`.
%
% Usage:
%   setup()              - auto-detect whether to enable `tr`
%   setup(true)          - explicitly enable `tr` (add project to path)
%   setup(false)         - explicitly disable `tr` (remove project from path)

% Behavior (priority):
% 1. explicit input argument to `setup(enableTr)` if provided
% 2. environment variable `MATLAB_TR` set to '1', 'true', or 'on'
% 3. presence of file `.tr_enabled` in project root
% 4. default: disabled (conservative)

function setup(varargin)
	shorthands = fileparts(fullfile(mfilename('fullpath'), 'shorthands'));

	% Parse name-value or positional argument
	wantEnable = [];
	if nargin == 1 && islogical(varargin{1}) || (nargin == 1 && isnumeric(varargin{1}))
		% positional boolean provided: setup(true) or setup(1)
		wantEnable = logical(varargin{1});
	else
		% Look for name-value pair 'enableTr'
		try
			p = inputParser();
			addParameter(p, 'enableTr', []);
			parse(p, varargin{:});
			wantEnable = p.Results.enableTr;
		catch
			% ignore parser errors and fall through to auto-detect
			wantEnable = [];
		end
	end

	% Determine desired state if still empty
	if isempty(wantEnable)
		% Check environment variable
		envVal = getenv('MATLAB_TR');
		if ~isempty(envVal)
			wantEnable = any(strcmpi(envVal, {'1','true','on'}));
		else
			% Check flag file
			flagFile = fullfile(shorthands, '.tr_enabled');
			wantEnable = isfile(flagFile);
		end
	end

	% Apply path changes
	onPath = contains(path, shorthands);
	if wantEnable
		if ~onPath
			addpath(shorthands);
			fprintf('MATLAB-Truthiness: enabled `tr` (added %s to path)\n', shorthands);
		else
			fprintf('MATLAB-Truthiness: `tr` already enabled (project on path)\n');
		end

		% Warn about multiple definitions
		try
			trAll = which('tr', '-all');
			if ischar(trAll)
				entries = strsplit(strtrim(trAll), '\n');
			else
				entries = trAll;
			end
			if numel(entries) > 1
				warning('MATLAB-Truthiness: multiple definitions of ''tr'' found. Using first on path: %s', entries{1});
			end
		catch
			% which may behave differently in some MATLAB versions; ignore failures
		end
	else
		if onPath
			rmpath(shorthands);
			fprintf('MATLAB-Truthiness: disabled `tr` (removed %s from path)\n', shorthands);
		else
			fprintf('MATLAB-Truthiness: `tr` is disabled (not on path)\n');
		end
	end
end
