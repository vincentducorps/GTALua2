#ifndef __INPUT_HOOK_H__
#define __INPUT_HOOK_H__

#pragma once

class InputHook
{
public:
	bool Initialize(HWND hWindow);
	void Remove();
	typedef void(*TKeyboardFn)(DWORD key, WORD repeats, BYTE scanCode, BOOL isExtended, BOOL isWithAlt, BOOL wasDownBefore, BOOL isUpNow);
	void keyboardHandlerRegister(TKeyboardFn function);
	void keyboardHandlerUnregister(TKeyboardFn function);
protected:
}; extern InputHook iHook;

static LRESULT APIENTRY WndProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

#endif // __INPUT_HOOK_H__