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

uses
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

var
  BundledStream: TBundledStream;
  Logger: TConsoleLogger;
begin
  if ParamCount < 1 then begin
    // TODO: also add support for files on disk
    Writeln(Format('Usage: %s <WSZ resource name in wmploc.dll>',
        [ExtractFileName(ParamStr(0))]));
    Exit;
  end;
  BundledStream := LoadStreamFromWMPLoc(ParamStr(1));
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
          on E: EReadError do // unexpected EOS?
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
