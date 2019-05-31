function [result, status] = python3(varargin)
%python3 Execute python3 command and return the result.
%   python3(python3FILE) calls python3 script specified by the file python3FILE
%   using appropriate python3 executable.
%
%   python3(python3FILE,ARG1,ARG2,...) passes the arguments ARG1,ARG2,...
%   to the python3 script file python3FILE, and calls it by using appropriate
%   python3 executable.
%
%   RESULT=python3(...) outputs the result of attempted python3 call.  If the
%   exit status of python3 is not zero, an error will be returned.
%
%   [RESULT,STATUS] = python3(...) outputs the result of the python3 call, and
%   also saves its exit status into variable STATUS.
%
%   If the python3 executable is not available, it can be downloaded from:
%     http://www.cpan.org
%
%   See also SYSTEM, JAVA, MEX.

%   Copyright 1990-2018 The MathWorks, Inc.

if nargin > 0
    [varargin{:}] = convertStringsToChars(varargin{:});
end

cmdString = '';

% Add input to arguments to operating system command to be executed.
% (If an argument refers to a file on the MATLAB path, use full file path.)
for i = 1:nargin
    thisArg = varargin{i};
    if ~ischar(thisArg)
        error(message('MATLAB:python3:InputsMustBeStrings'));
    end
    if i==1
        if exist(thisArg, 'file')==2
            % This is a valid file on the MATLAB path
            if isempty(dir(thisArg))
                % Not complete file specification
                % - file is not in current directory
                % - OR filename specified without extension
                % ==> get full file path
                thisArg = which(thisArg);
            end
        else
            % First input argument is python3File - it must be a valid file
            error(message('MATLAB:python3:FileNotFound', thisArg));
        end
    end
    
    % Wrap thisArg in double quotes if it contains spaces
    if isempty(thisArg) || any(thisArg == ' ')
        thisArg = ['"', thisArg, '"']; %#ok<AGROW>
    end
    
    % Add argument to command string
    cmdString = [cmdString, ' ', thisArg]; %#ok<AGROW>
end

% Check that the command string is not empty
if isempty(cmdString)
    error(message('MATLAB:python3:Nopython3Command'));
end

% Check that python3 is available if this is not a PC or isdeployed
if ~ispc || isdeployed
    if ispc
        checkCMDString = 'python3 -v';
    else
        checkCMDString = 'which python3';
    end
    [cmdStatus, ~] = system(checkCMDString);
    if cmdStatus ~=0
        error(message('MATLAB:python3:NoExecutable'));
    end
end

% Execute python3 script
cmdString = ['python3' cmdString];

if ispc && ~isdeployed
    % Add python3 to the path
    python3Inst = fullfile(matlabroot, '/usr/bin/python3');
    cmdString = ['set PATH=',python3Inst, ';%PATH%&' cmdString];
end
[status, result] = system(cmdString);

% Check for errors in shell command
if nargout < 2 && status~=0
    error(message('MATLAB:python3:ExecutionError', result, cmdString));
end


