
Keywords: NSIS, installer, privilege, exit, application, event

Below are the event creation code for the NSIS and C++ as I faced with problem initializing it correctly and googling did not help.

If we need to exit application which should be updated even it was launched with different administrative privileges and/or in other user session (via Fast User Switch feature, for example). 
It is possible to do with the event in the global namespace.


Below are the event creation code only, as wait and  reaction is obvious.

NSIS isnstaller part:

Function .onInit

 StrCpy $7 'Global\ExitNowEvent'

 System::Call 'kernel32::CreateEvent(p0, i0, i0, tr7) p.r8'

 System::Call 'kernel32::SetEvent(pr8)'

FunctionEnd

For me the code worked only with the function Call input enclosed in ''.


Following C++ code will create event with full access rights for everyone to the event. In security specific environment, security descriptor should be initialized keeping in mind necessary restrictions.


SECURITY_ATTRIBUTES sa = { 0 };

	sa.nLength = sizeof(sa);

	sa.bInheritHandle = false;

	PSECURITY_DESCRIPTOR pSD = 0;

	pSD = (PSECURITY_DESCRIPTOR) LocalAlloc(LPTR, SECURITY_DESCRIPTOR_MIN_LENGTH);

	if (pSD && InitializeSecurityDescriptor(pSD, SECURITY_DESCRIPTOR_REVISION))

	{

		SetSecurityDescriptorDacl(pSD, true, NULL, false);// Passing NULL as DACL to allow full access by everyone

		sa.lpSecurityDescriptor = pSD;

	}

		

	hExitImmediatelyEvent = CreateEvent(sa.lpSecurityDescriptor ? &sa : NULL,

		false, false, L"Global\\ExitNowEvent");


