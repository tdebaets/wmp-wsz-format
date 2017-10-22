(****************************************************************************
 *
 *            WMP WSZ Format
 *
 *            Copyright (c) 2017 Tim De Baets
 *
 ****************************************************************************
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 ****************************************************************************
 *
 * WSZ skin converter: main project file
 *
 ****************************************************************************)

program WMPWSZConvert;

{$APPTYPE CONSOLE}

{$R VersionInfo.res}

uses
{$IFDEF FastMM}
  FastMM4,
{$ENDIF FastMM}
  Windows,
  Classes,
  SysUtils,
  Common2,
  PathFunc,
  CmnFunc2,
  StreamUtil,
  WMPUtil,
  WMPWSZFormat;

type
  TConsoleLogger = class
  private
    procedure OnWSZParseLog(Sender: TObject; Level: TWMPWSZLogLevel;
        const Msg: String);
  end;

procedure TConsoleLogger.OnWSZParseLog(Sender: TObject; Level: TWMPWSZLogLevel;
    const Msg: String);
const
  LogLevelStrs: array[TWMPWSZLogLevel] of String = ('INFO', 'WARNING');
begin
  Writeln(Format('%s: %s', [LogLevelStrs[Level], Msg]));
end;

function LoadStreamFromFile(const Filename: String): TBundledStream;
begin
  Result := nil;
  try
    Result := TBundledStream.CreateFromFile(Filename,
        fmOpenRead or fmShareDenyNone);
  except
    on E: Exception do begin
      Writeln('ERROR: Failed to open file: ' + E.Message);
      ExitCode := 1;
    end;
  end;
end;

function LoadStreamFromWMPLoc(const ResName: String): TBundledStream;
var
  WMPLocPath: String;
begin
  Result := nil;
  WMPLocPath := AddBackslash(GetSystemDir) + WMPLocDll;
  if not NewFileExists(WMPLocPath) then begin
    Writeln('ERROR: wmploc.dll not found in system directory');
    ExitCode := 1;
    Exit;
  end;
  try
    Result := TBundledStream.CreateFromResource(WMPLocPath, ResName,
        PChar(WMPLocSkinResType));
  except
    on E: Exception do begin
      Writeln('ERROR: Failed to load resource from wmploc.dll: ' + E.Message);
      ExitCode := 1;
    end;
  end;
end;

procedure HandleErrorWithPosition(Position: Longint; const Msg: String);
begin
  Writeln(Format('ERROR: Failed to parse skin at position %u: %s',
      [Position, Msg]));
  ExitCode := 1;
end;

procedure HandleError(const Msg: String);
begin
  Writeln(Format('ERROR: Failed to parse skin: %s', [Msg]));
  ExitCode := 1;
end;

procedure ShowUsage;
var
  MyFilename: String;
begin
  MyFilename := ExtractFileName(ParamStr(0));
  Writeln;
  Writeln('Usage:');
  Writeln;
  Writeln(Format('%s <Filename of WSZ skin on disk>', [MyFilename]));
  Writeln(Format('%s <WSZ resource name in wmploc.dll>', [MyFilename]));
end;

var
  BundledStream: TBundledStream;
  Logger: TConsoleLogger;
begin
  if ParamCount < 1 then begin
    ShowUsage;
    Exit;
  end;
  if NewFileExists(ParamStr(1)) then
    BundledStream := LoadStreamFromFile(ParamStr(1))
  else begin
    Writeln(Format('WARNING: File %s not found, attempting to load it as a ' +
        'wmploc.dll resource instead...', [ParamStr(1)]));
    BundledStream := LoadStreamFromWMPLoc(ParamStr(1));
  end;
  if not Assigned(BundledStream) then
    Exit;
  try
    Logger := TConsoleLogger.Create;
    try
      with TWMPWSZParser.Create do try
        LogProc := Logger.OnWSZParseLog;
        try
          Parse(BundledStream.Stream);
        except
          on E: ESafeStreamError do
            HandleErrorWithPosition(E.Position, E.Message);
          on E: EWMPWSZParseError do
            HandleErrorWithPosition(E.Position, E.Message);
          on E: EReadError do // unexpected end-of-stream?
            HandleError(E.Message);
        end;
      finally
        Free;
      end;
    finally
      FreeAndNil(Logger);
    end;
  finally
    FreeAndNil(BundledStream);
  end;
end.
