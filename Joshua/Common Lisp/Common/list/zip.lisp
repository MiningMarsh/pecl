(defun zip (&rest lists)
	"Zips together multiple lists into a list of lists."
	(apply #'mapcar [%&] lists))
