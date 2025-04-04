document.addEventListener("DOMContentLoaded", function () {
  // Scroll to top of page
  window.scrollTo({ top: 0, behavior: "smooth" });

  const addbtn = document.getElementById("add-btn");
  let editbtn = document.getElementById("edit-btn");
  let deletebtn = document.getElementById("delete-btn");
  let inputText = document.querySelectorAll(".input-text");
  let confirmBtn = document.querySelector(".confirmBtn");
  let updateBtn = document.querySelector(".updateBtn");
  let collateralInput = document.getElementById("collateral");
  let collateralPreview = document.getElementById("collateral-preview");
  let radioBtn = document.querySelectorAll(".input-radio");
  let idPhotoInput = document.getElementById("idPhoto");
  let idPhotoPreview = document.getElementById("idPhotoPreview");
  let insurancePhotoInput = document.getElementById("insurancePhoto");
  let insurancePhotoPreview = document.getElementById("insurancePhotoPreview");
  let imgInput = document.querySelectorAll(".img-input");
  let profileDropdown = document.querySelector(".profile-dropdown");
  let arrowDownIcon = document.querySelector(".arrow-down-icon");
  let formHeader = document.querySelector(".form-header");
  let formHeader1 = document.querySelector(".form-header1");
  let dropdownIcon = document.querySelector(".arrow-header-icon");
  let dropdownIcon1 = document.querySelector(".arrow-header-icon1");
  let collapsableContainer = document.querySelector(".collapsable-container");
  let collapsableContainer1 = document.querySelector(".collapsable-container1");
  const notificationIcon = document.querySelector(".notification-icon");
  const notificationDropdown = document.querySelector(".notification-dropdown");

  const loanAmount = document.getElementById("loanAmount");

  let transaction_table = document.querySelector(".table-container");
  const borrowerForm = document.querySelector(".form-container form");

  const zooming = new Zooming();
  profileDropdown.addEventListener("mouseover", function () {
    console.log("hovered");
    arrowDownIcon.style.transform = "rotate(180deg)";
    arrowDownIcon.style.transition = "transform 0.5s ease";
  });

  profileDropdown.addEventListener("mouseout", function () {
    arrowDownIcon.style.transform = "rotate(0deg)";
    arrowDownIcon.style.transition = "transform 0.5s ease";
  });

  notificationIcon.addEventListener("click", function () {
    notificationDropdown.style.display =
      notificationDropdown.style.display === "block" ? "none" : "block";
  });
  // Close the dropdown if the user clicks outside of it
  window.addEventListener("click", function (event) {
    if (!event.target.closest(".notification")) {
      if (notificationDropdown.style.display === "block") {
        notificationDropdown.style.display = "none";
      }
    }
  });
  formHeader.addEventListener("click", function () {
    dropdownIcon.style.transform =
      dropdownIcon.style.transform === "rotate(180deg)"
        ? "rotate(0deg)"
        : "rotate(180deg)";

    collapsableContainer.style.display =
      collapsableContainer.style.display === "block" ? "none" : "block";
  });
  formHeader1.addEventListener("click", function () {
    dropdownIcon1.style.transform =
      dropdownIcon1.style.transform === "rotate(180deg)"
        ? "rotate(0deg)"
        : "rotate(180deg)";

    collapsableContainer1.style.display =
      collapsableContainer1.style.display === "block" ? "none" : "block";
  });

  addbtn.addEventListener("click", function () {
    console.log("clicked add button");
    addbtn.innerText = addbtn.innerText === "Add" ? "Cancel" : "Add";
    inputText.forEach(
      (input) => (input.disabled = input.disabled ? false : true)
    );
    radioBtn.forEach(
      (input) => (input.disabled = input.disabled ? false : true)
    );
    imgInput.forEach(
      (input) => (input.disabled = input.disabled ? false : true)
    );
    inputText.forEach((input) => (input.value = ""));
    searchInput.value = "";
    radioBtn.forEach((input) => (input.checked = false));
    imgInput.forEach((input) => (input.value = ""));
    collateralPreview.innerHTML = "";
    idPhotoPreview.innerHTML = "";
    insurancePhotoPreview.innerHTML = "";
    confirmBtn.style.display =
      confirmBtn.style.display === "block" ? "none" : "block";
    console.log(addbtn.innerText);
    deletebtn.disabled = true;
    deletebtn.style = "background-color: #ccc; color: #fff;";
    editbtn.disabled = true;
    editbtn.style = "background-color: #ccc; color: #fff;";
  });

  // confirmBtn.addEventListener("click", function () {
  //   // Validation code here
  // });

  borrowerForm.addEventListener("submit", function (e) {
    e.preventDefault();
    console.log();
    Swal.fire({
      title: "Are you sure?",
      text: "You want to add this borrower?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, add it!",
    }).then((result) => {
      if (result.isConfirmed) {
        console.log("Adding borrower...");
        const formData = new FormData(borrowerForm);

        // Add files to FormData
        const idPhotoInput = document.getElementById("idPhoto");
        const insurancePhotoInput = document.getElementById("insurancePhoto");
        const collateralInput = document.getElementById("collateral");

        if (idPhotoInput.files[0]) {
          formData.append("idPhoto", idPhotoInput.files[0]);
        }

        if (insurancePhotoInput.files[0]) {
          formData.append("insurancePhoto", insurancePhotoInput.files[0]);
        }

        if (collateralInput.files.length > 0) {
          for (let i = 0; i < collateralInput.files.length; i++) {
            formData.append("collateral[]", collateralInput.files[i]);
          }
        }

        fetch("scripts/AJAX/add_borrower.php", {
          method: "POST",
          body: formData,
        })
          .then((response) => response.json())
          .then((data) => {
            if (data.status === "success") {
              Swal.fire({
                title: "Added!",
                text: "Borrower has been added successfully.",
                icon: "success",
                timer: 3000,
                didClose: () => {
                  // Scroll after the alert is closed
                  window.requestAnimationFrame(() => {
                    window.scrollTo({
                      top: 0,
                      behavior: "smooth",
                      duration: 2000,
                    });
                  });
                },
              }).then(() => {
                // Reset form
                borrowerForm.reset();

                // Scroll to top of page
                window.scrollTo({ top: 0, behavior: "smooth" });
                if (window.scrollY != 0) {
                  window.scrollTo({ top: 0 });
                }

                // Clear previews
                document.getElementById("idPhotoPreview").innerHTML = "";
                document.getElementById("insurancePhotoPreview").innerHTML = "";
                document.getElementById("collateral-preview").innerHTML = "";

                // Disable inputs
                const inputs = document.querySelectorAll(
                  ".input-text, .input-radio, .img-input, select"
                );
                inputs.forEach((input) => (input.disabled = true));

                // Reset buttons
                document.getElementById("add-btn").innerHTML = "Add";
                document.getElementById("edit-btn").disabled = true;
                document.getElementById("delete-btn").disabled = true;
                confirmBtn.style.display = "none";

                exit();
                // Scroll to top of page
                window.scrollTo({ top: 0, behavior: "smooth" });
              });
            } else {
              console.error("Error:", data.message);
              Swal.fire("Error!", data.message, "error");
            }
          })
          .catch((error) => {
            console.error("Error:", error);
            Swal.fire(
              "Error!",
              "An error occurred while adding the borrower.",
              "error"
            );
          });
      }
    });
  });

  idPhotoInput.addEventListener("change", function () {
    idPhotoPreview.innerHTML = "";
    const file = idPhotoInput.files[0];
    const reader = new FileReader();
    reader.onload = function (e) {
      const img = document.createElement("img");
      img.src = e.target.result;
      img.style.maxWidth = "200px";
      img.style.margin = "10px";
      img.classList.add("zoomable");
      idPhotoPreview.appendChild(img);
      zooming.listen(img);
    };
    reader.readAsDataURL(file);
  });

  insurancePhotoInput.addEventListener("change", function () {
    insurancePhotoPreview.innerHTML = "";
    const file = insurancePhotoInput.files[0];
    const reader = new FileReader();
    reader.onload = function (e) {
      const img = document.createElement("img");
      img.src = e.target.result;
      img.style.maxWidth = "200px";
      img.style.margin = "10px";
      img.classList.add("zoomable");
      insurancePhotoPreview.appendChild(img);
      zooming.listen(img);
    };
    reader.readAsDataURL(file);
  });

  collateralInput.addEventListener(
    "change",
    function () {
      collateralPreview.innerHTML = ""; // Clear previous previews
      const files = collateralInput.files;
      for (let i = 0; i < files.length; i++) {
        const file = files[i];
        const reader = new FileReader();
        reader.onload = function (e) {
          const img = document.createElement("img");
          img.src = e.target.result;
          img.style.maxWidth = "200px";
          img.style.margin = "10px";
          img.classList.add("zoomable");
          collateralPreview.appendChild(img);
          zooming.listen(img);
        };
        reader.readAsDataURL(file);
      }
    },
    false
  );

  // Javascript for the table
  const tableAllBtn = document.getElementById("tblAllBtn");
  let tableAddBtn = document.getElementById("addBtn");
  const tablePaymentBtn = document.getElementById("tblPaymentBtn");
  const tableLoanBtn = document.getElementById("tblLoanBtn");
  const tableGroceryBtn = document.getElementById("tblGroceryBtn");

  // Modals for Payment, Loan, and Grocery
  const paymentModal = document.getElementById("paymentModal");
  const loanModal = document.getElementById("loanModal");
  const groceryModal = document.getElementById("groceryModal");
  const closeModalButtons = document.querySelectorAll(".close-modal");
  const today = new Date().toISOString().split("T")[0];

  const customerType = document.getElementById("customerType");
  let interestRate = document.getElementById("interestRate");

  tableAllBtn.addEventListener("click", function () {
    tableAddBtn.style.display = "none";
    tableAllBtn.classList.add("active");
    tableLoanBtn.classList.remove("active");
    tableGroceryBtn.classList.remove("active");
    tablePaymentBtn.classList.remove("active");
  });
  tablePaymentBtn.addEventListener("click", function () {
    tableAddBtn.style.display = "block";
    tableAddBtn.innerHTML = "Add New Payment";
    tablePaymentBtn.classList.add("active");
    tableLoanBtn.classList.remove("active");
    tableGroceryBtn.classList.remove("active");
    tableAllBtn.classList.remove("active");
  });
  tableLoanBtn.addEventListener("click", function () {
    tableAddBtn.style.display = "block";
    tableAddBtn.innerHTML = "Add New Loan";
    tableLoanBtn.classList.add("active");
    tableGroceryBtn.classList.remove("active");
    tablePaymentBtn.classList.remove("active");
    tableAllBtn.classList.remove("active");
  });
  tableGroceryBtn.addEventListener("click", function () {
    tableAddBtn.style.display = "block";
    tableAddBtn.innerHTML = "Add New Grocery";
    tableGroceryBtn.classList.add("active");
    tableLoanBtn.classList.remove("active");
    tablePaymentBtn.classList.remove("active");
    tableAllBtn.classList.remove("active");
  });

  tableAddBtn.addEventListener("click", function () {
    console.log("Add new item");
    if (tableAddBtn.innerHTML === "Add New Payment") {
      paymentModal.style.display = "block";
    } else if (tableAddBtn.innerHTML === "Add New Loan") {
      loanModal.style.display = "block";
    } else if (tableAddBtn.innerHTML === "Add New Grocery") {
      groceryModal.style.display = "block";
    }
  });

  closeModalButtons.forEach((button) => {
    button.addEventListener("click", function () {
      console.log("Close modal");
      const modalId = button.getAttribute("data-modal");
      document.getElementById(modalId).style.display = "none";

      // Clear all inputs except submit and clear buttons
      const modalInputs = document.querySelectorAll(
        `#${modalId} input:not([type="submit"]):not([type="reset"]):not([type="date"])`
      );
      modalInputs.forEach((input) => (input.value = ""));

      // Reset select elements if any
      const modalSelects = document.querySelectorAll(`#${modalId} select`);
      modalSelects.forEach((select) => (select.selectedIndex = 0));
    });
  });

  customerType.addEventListener("change", function () {
    if (customerType.value === "Regular") {
      interestRate.disabled = true;
      interestRate.value = "7";
    } else if (customerType.value === "VIP") {
      interestRate.disabled = true;
      interestRate.value = "5";
    } else if (customerType.value === "Other") {
      interestRate.value = "";
      interestRate.placeholder = "Enter interest rate";
      interestRate.disabled = false;
    } else {
      interestRate.value = "0";
      interestRate.disabled = true;
    }
  });
  // Move the interest rate validation outside the change event
  interestRate.addEventListener("input", function () {
    const value = parseFloat(this.value);
    if (value > 100) {
      this.value = 100;
    } else if (value < 0) {
      this.value = 0;
    }
  });

  // Set default date value to today
  document.getElementById("paymentDate").value = today;
  document.getElementById("loanDate").value = today;
  document.getElementById("groceryDate").value = today;

  // Start of AJAX Requests

  const searchInput = document.querySelector(".search-input");
  const searchBtn = document.querySelector(".search-btn");
  let searchResults = null;

  loanAmount.addEventListener("input", function (e) {
    formatNumber(this);
  });

  // Form validation
  const loanForm = document.querySelector("#loanModal form");
  // Update the loan form submission handler
  loanForm.addEventListener("submit", function (event) {
    event.preventDefault();

    const rawValue = loanAmount.value.replace(/,/g, "");
    const hiddenInput = document.createElement("input");

    loanAmount.name = "loanAmount_formatted";

    hiddenInput.type = "hidden";
    hiddenInput.name = "loanAmount";
    hiddenInput.value = rawValue;

    // Add the hidden input to the form
    this.appendChild(hiddenInput);

    // Validate loan date
    const loanDate = document.getElementById("loanDate").value;
    if (!loanDate) {
      Swal.fire({
        icon: "error",
        title: "Invalid Date",
        text: "Please select a valid loan date",
      });
      return;
    }

    // Format the date to YYYY-MM-DD
    const formattedDate = new Date(loanDate).toISOString().split("T")[0];

    console.log("Original loan date:", loanDate);
    console.log("Formatted loan date:", formattedDate);

    const formData = new FormData(loanForm);

    // Update the loan date in the form data
    formData.set("loanDate", formattedDate);

    // ... rest of your existing submit code ...

    const value = parseFloat(interestRate.value);

    if (value < 0 || value > 100) {
      Swal.fire({
        icon: "error",
        title: "Invalid Interest Rate",
        text: "Interest rate must be between 0% and 100%",
      });
      return;
    }
    console.log(originalValues);
    Swal.fire({
      icon: "warning",
      title: "Are you sure you want to add this loan?",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, add it!",
    }).then((result) => {
      console.log(originalValues);
      if (result.isConfirmed) {
        const formData = new FormData(loanForm);

        // Add borrower ID from the search/selection
        if (originalValues && originalValues.id) {
          formData.append("borrowerId", originalValues.id);
        } else {
          Swal.fire({
            icon: "error",
            title: "Error!",
            text: "Please select a borrower first.",
          });
          return;
        }

        // Add promissory note if exists
        const promissoryNote = document.getElementById("promissoryNote");
        if (promissoryNote && promissoryNote.files[0]) {
          formData.append("promissoryNote", promissoryNote.files[0]);
        }
        console.log(formData);
        fetch("scripts/AJAX/add_loan.php", {
          method: "POST",
          body: formData,
        })
          .then((response) => {
            if (!response.ok) {
              return response.json().then((err) => Promise.reject(err));
            }
            return response.json();
          })
          .then((data) => {
            if (data.status === "success") {
              Swal.fire({
                icon: "success",
                title: "Success!",
                text: "Loan has been successfully added.",
                timer: 3000,
              }).then(() => {
                // Reset form and modal
                loanForm.reset();
                document.getElementById("loanModal").style.display = "none";

                // Update table data
                loadTransactions("loan");
                interestRate.value = "";
                interestRate.disabled = true;
              });
            } else {
              throw new Error(data.message || "Failed to add loan");
            }
          })
          .catch((error) => {
            console.error("Error:", error);
            Swal.fire({
              icon: "error",
              title: "Error!",
              text:
                error.message ||
                "Failed to add loan. Make sure all required fields are filled correctly.",
            });
          });
      }
    });
  });

  // Update the search results display
  function createSearchResultsDropdown() {
    if (!searchResults) {
      searchResults = document.createElement("div");
      searchResults.className = "search-results-dropdown";
      const searchContainer = document.querySelector(".search-container");
      if (searchContainer) {
        searchContainer.appendChild(searchResults);
      }
    }
    return searchResults;
  }

  function performSearch() {
    const searchTerm = searchInput.value.trim();
    if (searchTerm.length < 1) {
      if (searchResults) searchResults.style.display = "none";
      return;
    }

    fetch("scripts/AJAX/search.php", {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: `search=${encodeURIComponent(searchTerm)}`,
    })
      .then((response) => response.json())
      .then((data) => {
        const dropdown = createSearchResultsDropdown();
        dropdown.innerHTML = "";

        if (data.status === "success" && data.data.length > 0) {
          data.data.forEach((user) => {
            const resultItem = document.createElement("div");
            resultItem.className = "search-result-item";
            resultItem.textContent = `${user.first_name} ${user.middle_name} ${user.surname}`;
            resultItem.addEventListener("click", () => {
              populateFormFields(user);
              addbtn.innerHTML = "Add";
              editbtn.innerHTML = "Edit";
              deletebtn.disabled = false;
              deletebtn.style = "color: white; background-color:red;";
              searchResults.style.display = "none";
              transaction_table.style.display = "block";
              searchInput.value = `${user.first_name} ${user.middle_name} ${user.surname}`;
              loadTransactions("all");
            });
            dropdown.appendChild(resultItem);
          });
          dropdown.style.display = "block";
        } else {
          dropdown.innerHTML =
            '<div class="search-result-item">No results found</div>';
          dropdown.style.display = "block";
        }
      })
      .catch((error) => {
        console.error("Search error:", error);
      });
  }

  // Update populateFormFields to match single column layout
  function populateFormFields(user) {
    // Personal Information
    const fields = {
      fName: user.first_name,
      mName: user.middle_name,
      surname: user.surname,
      suffix: user.suffix || "",
      DOB: user.dob,
      homeNo: user.home_no,
      street: user.street,
      baranggay: user.barangay,
      city: user.city,
      province: user.province,
      region: user.region,
      idType: user.id_type || "",
      idNo: user.id_no,
      expiryDate: user.expiry_date,
      employerName: user.employer_name,
      noOfYearsWorked: user.years_with_employer,
      position: user.position,
      phoneNoEmployer: user.employer_phone,
      salary: user.salary,
      EmployerhomeNo: user.employer_home_no,
      Employerstreet: user.employer_street,
      Employerbaranggay: user.employer_barangay,
      Employercity: user.employer_city,
      Employerprovince: user.employer_province,
      Employerregion: user.employer_region,
      insuranceType: user.insurance_provider || "",
      issuedDate: user.issued_date,
      expiryDateInsurance: user.insurance_expiry_date,
      dependentName: user.dependent_name,
      dependentContactNo: user.dependent_contact,
    };

    // Populate all fields
    Object.keys(fields).forEach((id) => {
      const element = document.getElementById(id);
      if (element) {
        element.value = fields[id] || "";
      }
    });

    // Handle radio buttons for sex
    const sexRadio = document.querySelector(
      `input[name="sex"][value="${user.sex}"]`
    );
    if (sexRadio) {
      sexRadio.checked = true;
    }

    // Handle file previews
    const previewContainers = {
      idPhotoPreview: user.id_photo_path,
      insurancePhotoPreview: user.insurance_file_path,
      "collateral-preview": user.collateral_files,
    };

    Object.entries(previewContainers).forEach(([containerId, filePath]) => {
      const container = document.getElementById(containerId);
      if (container && filePath) {
        container.innerHTML = "";

        if (containerId === "collateral-preview" && filePath) {
          const files = filePath.split(",");
          files.forEach((file) => {
            const img = createPreviewImage(`images/uploads/${file.trim()}`);
            container.appendChild(img);
          });
        } else if (filePath) {
          const img = createPreviewImage(`images/uploads/${filePath}`);
          container.appendChild(img);
        }
      }
    });

    // Update button states
    updateButtonStates(true);
    searchResults.style.display = "none";

    // Store original values for edit/cancel functionality
    storeOriginalValues(user);
  }

  // Helper function to create preview images
  function createPreviewImage(src) {
    const img = document.createElement("img");
    img.src = src;
    img.style.maxWidth = "200px";
    img.style.margin = "10px";
    img.classList.add("zoomable");

    // Initialize zooming functionality
    if (typeof zooming !== "undefined") {
      zooming.listen(img);
    }

    return img;
  }

  // Helper function to update button states
  function updateButtonStates(hasData) {
    const editBtn = document.getElementById("edit-btn");
    const deleteBtn = document.getElementById("delete-btn");
    const addBtn = document.getElementById("add-btn");

    if (editBtn && deleteBtn && addBtn) {
      editBtn.disabled = !hasData;
      deleteBtn.disabled = !hasData;
      editBtn.style.backgroundColor = hasData ? "#4CAF50" : "#C1C1C1";
      deleteBtn.style.backgroundColor = hasData ? "#f44336" : "#C1C1C1";
      addBtn.innerHTML = "Add";
    }
  }

  // Helper function to store original values
  function storeOriginalValues(user) {
    originalValues = {
      id: user.id,
      ...user,
    };
  }

  function handleEditClick() {
    if (editbtn.innerHTML === "Edit") {
      // Enable all form inputs for editing
      const inputs = document.querySelectorAll(
        ".input-text, .input-radio, .img-input, select"
      );
      inputs.forEach((input) => (input.disabled = false));

      editbtn.innerHTML = "Cancel";
      editbtn.style =
        "cursor:pointer; background-color: #f44336; color: white;";
      addbtn.disabled = true;
      addbtn.style = "cursor:pointer; background-color: #ccc; color: white;";
      deletebtn.disabled = true;
      deletebtn.style = "cursor:pointer; background-color: #ccc; color: white;";
      updateBtn.style.display = "block";
    } else if (editbtn.innerHTML === "Cancel") {
      // Restore all original values
      Object.keys(originalValues).forEach((key) => {
        const element = document.getElementById(key);
        if (element) {
          if (element.type === "radio") {
            const radio = document.querySelector(
              `input[name="${key}"][value="${originalValues[key]}"]`
            );
            if (radio) radio.checked = true;
          } else if (element.tagName === "SELECT") {
            element.value = originalValues[key] || "";
          } else {
            element.value = originalValues[key] || "";
          }
        }
      });

      // Handle sex radio button specifically
      if (originalValues.sex) {
        const sexRadio = document.querySelector(
          `input[name="sex"][value="${originalValues.sex}"]`
        );
        if (sexRadio) sexRadio.checked = true;
      }

      // Restore photo previews
      if (originalValues.id_photo) {
        const idPhotoPreview = document.getElementById("idPhotoPreview");
        idPhotoPreview.innerHTML = `<img src="images/uploads/${originalValues.id_photo}" style="max-width: 200px; margin: 10px;" class="zoomable">`;
        const zoomable = idPhotoPreview.querySelector(".zoomable");
        if (zoomable) zooming.listen(zoomable);
      }

      if (originalValues.insurance_file) {
        const insurancePhotoPreview = document.getElementById(
          "insurancePhotoPreview"
        );
        insurancePhotoPreview.innerHTML = `<img src="images/uploads/${originalValues.insurance_file}" style="max-width: 200px; margin: 10px;" class="zoomable">`;
        const zoomable = insurancePhotoPreview.querySelector(".zoomable");
        if (zoomable) zooming.listen(zoomable);
      }

      if (originalValues.collateral_files) {
        const collateralPreview = document.getElementById("collateral-preview");
        collateralPreview.innerHTML = ""; // Clear previous previews

        // Split the comma-separated string of file paths
        const collateralFiles = originalValues.collateral_files.split(",");
        // Create image elements for each collateral file
        collateralFiles.forEach((filePath) => {
          const img = document.createElement("img");
          img.src = "images/uploads/" + filePath;
          img.style.maxWidth = "200px";
          img.style.margin = "10px";
          img.classList.add("zoomable");
          collateralPreview.appendChild(img);
          zooming.listen(img);
        });
      }

      console.log(originalValues);
      // Disable all inputs
      const inputs = document.querySelectorAll(
        ".input-text, .input-radio, .img-input, select"
      );
      inputs.forEach((input) => (input.disabled = true));

      // Reset edit button
      editbtn.innerHTML = "Edit";
      editbtn.style =
        "cursor:pointer; background-color: #4CAF50; color: white;";
      addbtn.disabled = false;
      addbtn.style = "cursor:pointer; background-color: #1E3E62; color: white;";
      deletebtn.disabled = false;
      deletebtn.style =
        "cursor:pointer; background-color: #f44336; color: white;";
      updateBtn.style.display = "none";
    }
  }
  // Update the updateBtn click handler:

  updateBtn.addEventListener("click", function (e) {
    e.preventDefault();

    Swal.fire({
      title: "Are you sure?",
      text: "You want to update this borrower's information?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, update it!",
    }).then((result) => {
      if (result.isConfirmed) {
        const formData = new FormData(borrowerForm);

        // Add existing file paths and ID
        formData.append("id", originalValues.id);
        formData.append("existing_id_photo", originalValues.id_photo || "");
        formData.append(
          "existing_insurance_file",
          originalValues.insurance_file || ""
        );
        formData.append(
          "existing_collateral_files",
          originalValues.collateral_files || ""
        );

        // Add new files if selected
        const idPhotoInput = document.getElementById("idPhoto");
        const insurancePhotoInput = document.getElementById("insurancePhoto");
        const collateralInput = document.getElementById("collateral");

        if (idPhotoInput.files[0]) {
          formData.append("idPhoto", idPhotoInput.files[0]);
        }

        if (insurancePhotoInput.files[0]) {
          formData.append("insurancePhoto", insurancePhotoInput.files[0]);
        }

        if (collateralInput.files.length > 0) {
          for (let i = 0; i < collateralInput.files.length; i++) {
            formData.append("collateral[]", collateralInput.files[i]);
          }
        }

        fetch("scripts/AJAX/edit_borrower.php", {
          method: "POST",
          body: formData,
        })
          .then((response) => {
            if (!response.ok) {
              throw new Error("Network response was not ok");
            }
            return response.json();
          })
          .then((data) => {
            if (data.status === "success") {
              Swal.fire({
                icon: "success",
                title: "Updated!",
                text: "Borrower information has been updated successfully.",
                timer: 3000,
                willClose: () => {
                  window.scrollTo({
                    top: 0,
                  });
                },
                didClose: () => {
                  // Scroll after the alert is closed
                  window.requestAnimationFrame(() => {
                    window.scrollTo({
                      top: 0,
                      behavior: "smooth",
                      duration: 2000,
                    });
                  });
                },
              }).then(() => {
                // Update originalValues with new data
                if (idPhotoInput.files[0]) {
                  originalValues.id_photo_path = data.id_photo_path;
                }
                if (insurancePhotoInput.files[0]) {
                  originalValues.insurance_file_path = data.insurance_file_path;
                }
                if (collateralInput.files.length > 0) {
                  originalValues.collateral_files = data.collateral_files;
                }

                // Disable inputs and reset buttons
                const inputs = document.querySelectorAll(
                  ".input-text, .input-radio, .img-input, select"
                );
                inputs.forEach((input) => (input.disabled = true));

                editbtn.innerHTML = "Edit";
                editbtn.style =
                  "cursor:pointer; background-color: #4CAF50; color: white;";
                addbtn.disabled = false;
                addbtn.style =
                  "cursor:pointer; background-color: #1E3E62; color: white;";
                deletebtn.disabled = false;
                deletebtn.style =
                  "cursor:pointer; background-color: #f44336; color: white;";
                updateBtn.style.display = "none";
              });
            } else {
              throw new Error(data.message || "Update failed");
            }
          })
          .catch((error) => {
            console.error("Error:", error);
            Swal.fire({
              icon: "error",
              title: "Error!",
              text: "An error occurred while updating the borrower information.",
            });
          });
      }
    });
  });

  // Add debounce to search
  function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
      const later = () => {
        clearTimeout(timeout);
        func(...args);
      };
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
    };
  }

  // Event listeners
  searchInput.addEventListener("input", debounce(performSearch, 300));
  searchBtn.addEventListener("click", performSearch);

  // Close search results when clicking outside
  document.addEventListener("click", (e) => {
    if (!e.target.closest(".search-container") && searchResults) {
      searchResults.style.display = "none";
    }
  });

  // Add delete button functionality
  deletebtn.addEventListener("click", function () {
    Swal.fire({
      title: "Are you sure?",
      text: "You won't be able to revert this!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#d33",
      cancelButtonColor: "#3085d6",
      confirmButtonText: "Yes, delete it!",
    }).then((result) => {
      if (result.isConfirmed) {
        // Get the selected user's ID from the originalValues
        const userId = originalValues.id;

        // Send delete request to server
        fetch("scripts/AJAX/delete_borrower.php", {
          method: "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: `id=${userId}`,
        })
          .then((response) => response.json())
          .then((data) => {
            if (data.status === "success") {
              Swal.fire(
                "Deleted!",
                "User has been deleted.",
                "success",
                3000
              ).then(() => {
                // Clear form
                const form = document.querySelector("form");
                form.reset();

                // Clear previews
                document.getElementById("idPhotoPreview").innerHTML = "";
                document.getElementById("insurancePhotoPreview").innerHTML = "";
                document.getElementById("collateral-preview").innerHTML = "";

                // Disable buttons
                editbtn.disabled = true;
                deletebtn.disabled = true;
                deletebtn.style = "background-color: #ccc; color: #fff;";
                editbtn.style = "background-color: #ccc; color: #fff;";

                // Clear search input
                document.querySelector(".search-input").value = "";

                // Disable all inputs
                const inputs = document.querySelectorAll(
                  ".input-text, .input-radio, .img-input, select"
                );
                inputs.forEach((input) => (input.disabled = true));
              });
            } else {
              Swal.fire("Error!", "Failed to delete user.", "error");
            }
          })
          .catch((error) => {
            console.error("Delete error:", error);
            Swal.fire("Error!", "An error occurred while deleting.", "error");
          });
      }
    });
  });

  const groceryForm = document.getElementById("groceryForm");

  groceryForm.addEventListener("submit", function (event) {
    event.preventDefault();

    const groceryRawValue = groceryAmount.value.replace(/,/g, "");

    const hiddenGroceryInput = document.createElement("input");
    hiddenGroceryInput.type = "hidden";
    hiddenGroceryInput.name = "groceryAmount";
    hiddenGroceryInput.value = groceryRawValue;

    groceryAmount.name = "groceryAmount_formatted";

    this.appendChild(hiddenGroceryInput);

    // Validate borrower selection
    if (!originalValues || !originalValues.id) {
      Swal.fire({
        icon: "error",
        title: "Error!",
        text: "Please select a borrower first.",
      });
      return;
    }

    // Validate amount
    const amount = parseFloat(document.getElementById("groceryAmount").value);
    if (isNaN(amount) || amount <= 0) {
      Swal.fire({
        icon: "error",
        title: "Invalid Amount",
        text: "Please enter a valid amount greater than 0.",
      });
      return;
    }

    const formData = new FormData(groceryForm);
    formData.append("borrowerId", originalValues.id);

    Swal.fire({
      title: "Are you sure?",
      text: "You want to add this grocery record?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, add it!",
    }).then((result) => {
      if (result.isConfirmed) {
        fetch("scripts/AJAX/add_grocery.php", {
          method: "POST",
          body: formData,
        })
          .then((response) => response.json())
          .then((data) => {
            if (data.status === "success") {
              Swal.fire({
                icon: "success",
                title: "Success!",
                text: data.message,
                timer: 3000,
              }).then(() => {
                // Reset form and close modal
                groceryForm.reset();
                document.getElementById("groceryModal").style.display = "none";
                // Update table data
                // loadLoans(originalValues.id);
              });
            } else {
              throw new Error(data.message || "Failed to add grocery");
            }
          })
          .catch((error) => {
            console.error("Error:", error);
            Swal.fire({
              icon: "error",
              title: "Error!",
              text: error.message || "Failed to add grocery. Please try again.",
            });
          });
      }
    });
  });

  // Add validation for grocery amount
  const groceryAmount = document.getElementById("groceryAmount");
  groceryAmount.addEventListener("input", function () {
    formatNumber(this);
    if (this.value < 0) {
      this.value = 0;
    }
  });
  // const customerType = document.getElementById("customerType");
  // const interestRate = document.getElementById("interestRate");
  const loanDate = document.getElementById("loanDate");
  const term = document.getElementById("term");
  const repaymentDate = document.getElementById("repaymentDate");

  // Enable interest rate input based on customer type
  customerType.addEventListener("change", function () {
    interestRate.disabled = false;
  });

  // Generate unique reference number
  function generateReferenceNo() {
    const timestamp = new Date().getTime();
    return "LN-" + timestamp;
  }

  // Auto-calculate repayment date
  function calculateRepaymentDate() {
    if (loanDate.value && term.value) {
      let loanDateObj = new Date(loanDate.value);
      loanDateObj.setMonth(loanDateObj.getMonth() + parseInt(term.value));
      repaymentDate.value = loanDateObj.toISOString().split("T")[0];
    }
  }

  term.addEventListener("input", calculateRepaymentDate);
  loanDate.addEventListener("input", calculateRepaymentDate);

  // When form submits, attach reference number
  document.querySelector("form").addEventListener("submit", function (e) {
    document
      .querySelector("form")
      .insertAdjacentHTML(
        "beforeend",
        `<input type="hidden" name="reference_no" value="${generateReferenceNo()}">`
      );
  });
});

// Helper function to format dates
function formatDate(dateString) {
  const date = new Date(dateString);
  return date.toLocaleDateString("en-US", {
    month: "2-digit",
    day: "2-digit",
    year: "numeric",
  });
}

// Helper function to format currency
function formatCurrency(amount) {
  return new Intl.NumberFormat("en-PH", {
    style: "currency",
    currency: "PHP",
  }).format(amount);
}

// Function to handle viewing promissory note
function viewPromissoryNote(filePath) {
  if (!filePath) {
    Swal.fire({
      icon: "error",
      title: "Error",
      text: "No promissory note file found",
    });
    return;
  }

  const modal = document.getElementById("promissoryNoteModal");
  const previewContainer = document.getElementById("promissoryNotePreview");
  const fileExtension = filePath.split(".").pop().toLowerCase();

  // Clear previous content
  previewContainer.innerHTML = "";

  // Create preview based on file type
  if (fileExtension === "pdf") {
    previewContainer.innerHTML = `
             <div class="pdf-container">
                <iframe
                    src="images/uploads/promissory_notes/${filePath}"
                    type="application/pdf"
                    width="100%"
                    height="600px"
                    style="border: none;"
                ></iframe>
                <div class="pdf-controls">
                    <a href="images/uploads/promissory_notes/${filePath}" 
                       target="_blank" 
                       class="download-button">
                        Open in New Tab
                    </a>
                </div>
            </div>
        `;
  } else if (["jpg", "jpeg", "png"].includes(fileExtension)) {
    const img = document.createElement("img");
    img.src = `images/uploads/promissory_notes/${filePath}`;
    img.className = "zoomable";
    previewContainer.appendChild(img);

    // Initialize zooming for images
    const zooming = new Zooming({
      bgColor: "#000",
      bgOpacity: 0.8,
      customSize: "100%",
    });
    zooming.listen(img);
  } else {
    previewContainer.innerHTML = `
            <div style="text-align: center; padding: 20px;">
                <p>File type not supported for preview.</p>
                <a href="${filePath}" 
                   target="_blank" 
                   class="view-button">
                    Download file instead
                </a>
            </div>
        `;
  }

  // Show the modal
  modal.style.display = "block";

  // Close modal functionality
  const closeModal = () => {
    modal.style.display = "none";
    previewContainer.innerHTML = ""; // Clear content when closing
  };

  // Close button handler
  const closeButton = modal.querySelector(".close-modal");
  closeButton.onclick = closeModal;

  // Debug logging
  console.log("Opening file:", filePath);
  console.log("File extension:", fileExtension);
}

// Function to handle payment// Function to handle payment
function handlePayment(referenceNo) {
  // Get the payment details first
  fetch(`scripts/AJAX/get_payment_details.php?reference_no=${referenceNo}`)
    .then((response) => response.json())
    .then((data) => {
      if (data.status === "success") {
        const fullAmount = data.amount;

        // Show payment options dialog
        Swal.fire({
          title: "Payment Options",
          html: `
            <div class="payment-options">
              <button class="full-pay-btn" onclick="handleFullPayment('${referenceNo}', ${fullAmount})">
                Full Payment (${formatCurrency(fullAmount)})
              </button>
              <div class="custom-pay">
                <input type="number" id="customAmount" 
                  class="swal2-input" placeholder="Enter custom amount"
                  min="1" max="${fullAmount}" step="0.01">
                <button onclick="handleCustomPayment('${referenceNo}')">
                  Pay Custom Amount
                </button>
              </div>
            </div>
          `,
          showConfirmButton: false,
          showCloseButton: true,
        });
      } else {
        Swal.fire({
          icon: "error",
          title: "Error",
          text: "Could not fetch payment details",
        });
      }
    })
    .catch((error) => {
      console.error("Error:", error);
      Swal.fire({
        icon: "error",
        title: "Error",
        text: "An error occurred while processing your request",
      });
    });
}
function handleFullPayment(referenceNo, amount) {
  submitPayment(referenceNo, amount);
}

function handleCustomPayment(referenceNo) {
  const customAmount = document.getElementById("customAmount").value;
  if (!customAmount || customAmount <= 0) {
    Swal.fire({
      icon: "error",
      title: "Invalid Amount",
      text: "Please enter a valid payment amount",
    });
    return;
  }
  submitPayment(referenceNo, customAmount);
}

function submitPayment(referenceNo, amount) {
  fetch("scripts/AJAX/process_payment.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      reference_no: referenceNo,
      amount: amount,
    }),
  })
    .then((response) => response.json())
    .then((data) => {
      if (data.status === "success") {
        Swal.fire({
          icon: "success",
          title: "Payment Successful",
          text: `Payment of ${formatCurrency(amount)} has been processed`,
          timer: 2000,
        }).then(() => {
          // Refresh the transactions table
          loadTransactions("all");
        });
      } else {
        throw new Error(data.message || "Payment failed");
      }
    })
    .catch((error) => {
      Swal.fire({
        icon: "error",
        title: "Payment Failed",
        text: error.message || "An error occurred while processing the payment",
      });
    });
}

// Update loadLoans when a new loan is added
// function updateTableData() {
//   loadLoans();
// }
function formatNumber(input) {
  // Remove existing commas and non-numeric characters (except decimal point)
  let value = input.value.replace(/,/g, "").replace(/[^\d.]/g, "");
  // Format with commas
  let parts = value.split(".");
  parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  input.value = parts.join(".");
}

// Add these functions to handle table switching
function showTable(tableId) {
  // Hide all tables
  document.querySelectorAll(".transaction-table").forEach((table) => {
    table.style.display = "none";
  });

  // Show selected table
  document.getElementById(tableId).style.display = "table";
}

// Update event listeners for table buttons
document.getElementById("tblAllBtn").addEventListener("click", () => {
  clearTransactionInterval();
  showTable("allTable");
  loadTransactions("all");
});

document.getElementById("tblLoanBtn").addEventListener("click", () => {
  clearTransactionInterval();
  showTable("loanTable");
  loadTransactions("loan");
});

document.getElementById("tblPaymentBtn").addEventListener("click", () => {
  clearTransactionInterval();
  showTable("paymentTable");
  loadTransactions("payment");
});

document
  .getElementById("tblPendingPaymentBtn")
  .addEventListener("click", () => {
    clearTransactionInterval();
    showTable("pendingPaymentTable");
    loadTransactions("payment");
  });
document.getElementById("tblGroceryBtn").addEventListener("click", () => {
  clearTransactionInterval();
  showTable("groceryTable");
  loadTransactions("grocery");
});

let transactionRefreshInterval;
// Function to load transactions based on type
function loadTransactions(type) {
  // Use optional chaining for originalValues
  if (!originalValues?.id) {
    console.warn("No borrower selected");
    return;
  }
  // Clear any existing interval
  if (transactionRefreshInterval) {
    clearInterval(transactionRefreshInterval);
  }
  // Initial load
  fetchTransactions(type);
  // Set up interval for subsequent loads
  transactionRefreshInterval = setInterval(() => {
    fetchTransactions(type);
  }, 1000); // 1 second interval

  fetch(
    `scripts/AJAX/get_transactions.php?type=${type}&borrowerId=${originalValues.id}`
  )
    .then((response) => response.json())
    .then((data) => {
      // Use optional chaining for data.status check
      if (data?.status === "success") {
        updateTableContent(type, data?.data || []);
      } else {
        console.warn("Invalid response format:", data);
      }
    })
    .catch((error) => {
      console.error("Error loading transactions:", error);
      // Add error state handling for the UI
      const tableId = getTableId(type);
      const tbody = document.querySelector(`#${tableId} tbody`);
      if (tbody) {
        tbody.innerHTML = `
        <tr>
          <td colspan="11" class="text-center">
            Error loading transactions. Please try again.
          </td>
        </tr>
      `;
      }
    });
}

// Helper function to fetch transactions
function fetchTransactions(type) {
  // Use optional chaining for originalValues
  if (!originalValues?.id) {
    console.warn("No borrower selected");
    return;
  }

  fetch(
    `scripts/AJAX/get_transactions.php?type=${type}&borrowerId=${originalValues.id}`
  )
    .then((response) => response.json())
    .then((data) => {
      if (data?.status === "success") {
        updateTableContent(type, data?.data || []);
      } else {
        console.warn("Invalid response format:", data);
      }
    })
    .catch((error) => {
      console.error("Error loading transactions:", error);
      const tableId = getTableId(type);
      const tbody = document.querySelector(`#${tableId} tbody`);
      if (tbody) {
        tbody.innerHTML = `
          <tr>
            <td colspan="11" class="text-center text-danger">
              Error loading transactions. Please try again.
            </td>
          </tr>
        `;
      }
    });
}

// Add cleanup function to clear interval when switching views
function clearTransactionInterval() {
  if (transactionRefreshInterval) {
    clearInterval(transactionRefreshInterval);
    transactionRefreshInterval = null;
  }
}
function getTableId(type) {
  return type === "all"
    ? "allTable"
    : type === "loan"
    ? "loanTable"
    : type === "payment"
    ? "paymentTable"
    : "groceryTable";
}

// Function to update table content based on type
function updateTableContent(type, data) {
  const tableId =
    type === "all"
      ? "allTable"
      : type === "loan"
      ? "loanTable"
      : type === "payment"
      ? "paymentTable"
      : "groceryTable";

  const tbody = document.querySelector(`#${tableId} tbody`);
  tbody.innerHTML = "";

  data.forEach((item) => {
    const row = document.createElement("tr");
    row.innerHTML = generateRowContent(type, item);
    tbody.appendChild(row);
  });
}

// Function to generate row content based on transaction type
function generateRowContent(type, item) {
  switch (type) {
    case "loan":
      return `
              <td>${formatDate(item.loan_date)}</td>
              <td>${item.reference_no}</td>
              <td>${item.customer_type}</td>
              <td>${formatDate(item.repayment_date)}</td>
              <td>${formatCurrency(item.loan_amount)}</td>
              <td>${item.interest_rate}%</td>
              <td>${item.term_months}</td>
              <td><button onclick="viewPromissoryNote('${
                item.promissory_file_path
              }')" ${
        item.promissory_file_path ? "" : "disabled"
      }>View</button></td>
              <td>${item.remarks}</td>
              <td>${formatCurrency(item.loan_balance)}</td>
              <td><button onclick="handlePayment('${
                item.reference_no
              }')">Edit</button></td>
          `;
    case "payment":
      return `
              <td>${formatDate(item.payment_date)}</td>
              <td>${item.reference_no}</td>
              <td>${formatCurrency(item.principal_amount)}</td>
              <td>${formatCurrency(item.interest_amount)}</td>
              <td>${formatCurrency(item.payment_amount)}</td>
              <td>${formatCurrency(item.paid_amount)}</td>
              <td>${item.remarks}</td>
              <td>${item.status}</td>
              <td>${
                item.status === "paid"
                  ? '<span class="badge-paid">Paid</span>'
                  : `<button onclick="paymentclick('${item.reference_no}')">Pay</button>`
              }</td>
          `;
    case "grocery":
      return `
                <td>${formatDate(item.grocery_date)}</td>
                <td>${item.reference_no}</td>
                <td>${formatCurrency(item.grocery_amount)}</td>
                <td>${item.remarks}</td>
                <td>${formatCurrency(item.balance)}</td>
                <td>
                    <button onclick="handlePayment('${
                      item.reference_no
                    }')">Pay</button>
                </td>
            `;
    default:
      // All transactions table
      return `
              <td>${item.created_at}</td>
              <td>${item.reference_no}</td>
              <td>${item.transaction_type}</td>
              <td>${
                item.repayment_date ? formatDate(item.repayment_date) : "N/A"
              }</td>
              <td>${formatCurrency(item.amount)}</td>
              <td>${item.interest_rate ? item.interest_rate + "%" : "N/A"}</td>
              <td>${item.term_months || "N/A"}</td>
              <td>${
                item.promissory_file_path
                  ? "<button onclick=\"viewPromissoryNote('" +
                    item.promissory_file_path +
                    "')\">View</button>"
                  : "N/A"
              }</td>
              <td>${item.remarks}</td>
              <td>${formatCurrency(item.balance)}</td>
              <td><button onclick="handlePayment('${
                item.reference_no
              }')">Pay</button></td>
          `;
  }
}

function paymentclick(referenceNo) {
  // Get the payment details first
  fetch(`scripts/AJAX/get_payment_details.php?reference_no=${referenceNo}`)
    .then((response) => response.json())
    .then((data) => {
      if (data.status === "success") {
        const fullAmount = data.amount;

        // Show payment options dialog
        Swal.fire({
          title: "Payment Options",
          html: `
                      <div class="payment-options">
                          <button class="full-pay-btn" onclick="handleFullPayment('${referenceNo}', ${fullAmount})">
                              Full Payment (${formatCurrency(fullAmount)})
                          </button>
                          <div class="custom-pay">
                              <input type="number" id="customAmount" 
                                  class="swal2-input" placeholder="Enter custom amount"
                                  min="1" max="${fullAmount}" step="0.01">
                              <button onclick="handleCustomPayment('${referenceNo}')">
                                  Pay Custom Amount
                              </button>
                          </div>
                      </div>
                  `,
          showConfirmButton: false,
          showCloseButton: true,
        });
      } else {
        Swal.fire({
          icon: "error",
          title: "Error",
          text: "Could not fetch payment details",
        });
      }
    })
    .catch((error) => {
      console.error("Error:", error);
      Swal.fire({
        icon: "error",
        title: "Error",
        text: "An error occurred while processing your request",
      });
    });
}

function handleFullPayment(referenceNo, amount) {
  submitPayment(referenceNo, amount);
}

function handleCustomPayment(referenceNo) {
  const customAmount = document.getElementById("customAmount").value;
  if (!customAmount || customAmount <= 0) {
    Swal.fire({
      icon: "error",
      title: "Invalid Amount",
      text: "Please enter a valid payment amount",
    });
    return;
  }
  submitPayment(referenceNo, customAmount);
}

function submitPayment(referenceNo, amount) {
  fetch("scripts/AJAX/process_payment.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      reference_no: referenceNo,
      amount: amount,
    }),
  })
    .then((response) => response.json())
    .then((data) => {
      if (data.status === "success") {
        Swal.fire({
          icon: "success",
          title: "Payment Successful",
          text: `Payment of ${formatCurrency(amount)} has been processed`,
          timer: 2000,
        }).then(() => {
          // Refresh the transactions table
          loadTransactions("all");
        });
      } else {
        throw new Error(data.message || "Payment failed");
      }
    })
    .catch((error) => {
      Swal.fire({
        icon: "error",
        title: "Payment Failed",
        text: error.message || "An error occurred while processing the payment",
      });
    });
}

function fetchNotifications(showAll = false) {
  fetch("scripts/AJAX/notification.php")
    .then((response) => response.json())
    .then((data) => {
      if (data.status === "success") {
        const notificationDropdown = document.querySelector(
          ".notification-dropdown-content"
        );

        if (data.count > 0) {
          // Update notification icon to show count
          const notificationCount = document.createElement("span");
          notificationCount.className = "notification-count";
          notificationCount.textContent = data.count;
          document
            .querySelector(".notification-icon")
            .appendChild(notificationCount);

          // Clear existing notifications
          notificationDropdown.innerHTML = "";

          // Determine how many notifications to show
          const notificationsToShow = showAll
            ? data.notifications
            : data.notifications.slice(0, 3);

          // Add notifications
          notificationsToShow.forEach((notification) => {
            const notifItem = document.createElement("div");
            notifItem.className = "notification-item";

            // Add urgency class based on days remaining
            if (notification.days_remaining <= 7) {
              notifItem.classList.add("urgent");
            } else if (notification.days_remaining <= 14) {
              notifItem.classList.add("warning");
            }

            notifItem.innerHTML = `
                          <p>${notification.message}</p>
                          <small>${notification.type}</small>
                      `;
            notificationDropdown.appendChild(notifItem);
          });

          // Add "View More" button if there are more than 3 notifications
          if (!showAll && data.notifications.length > 3) {
            const viewMoreBtn = document.createElement("div");
            viewMoreBtn.className = "view-more-btn";
            viewMoreBtn.innerHTML = `
                          <button>
                              View More (${data.notifications.length - 3} more)
                          </button>
                      `;
            viewMoreBtn.addEventListener("click", () => {
              fetchNotifications(true);
            });
            notificationDropdown.appendChild(viewMoreBtn);
          }

          // Add "Show Less" button when showing all notifications
          if (showAll && data.notifications.length > 3) {
            const showLessBtn = document.createElement("div");
            showLessBtn.className = "view-more-btn";
            showLessBtn.innerHTML = "<button>Show Less</button>";
            showLessBtn.addEventListener("click", () => {
              fetchNotifications(false);
            });
            notificationDropdown.appendChild(showLessBtn);
          }
        } else {
          notificationDropdown.innerHTML = "<p>No new notifications</p>";
        }
      }
    })
    .catch((error) => console.error("Error:", error));
}

// Call fetchNotifications when page loads and every 5 minutes
document.addEventListener("DOMContentLoaded", function () {
  fetchNotifications();
  setInterval(fetchNotifications, 300000); // 5 minutes
});

// Add click event listener for notification icon if not already present
if (!document.querySelector(".notification-icon").hasAttribute("listener")) {
  document.querySelector(".notification-icon").setAttribute("listener", "true");
  document
    .querySelector(".notification-icon")
    .addEventListener("click", function () {
      const dropdown = document.querySelector(".notification-dropdown");
      dropdown.style.display =
        dropdown.style.display === "block" ? "none" : "block";
    });
}

// Replace the existing notification click handler
document
  .querySelector(".notification-icon")
  .addEventListener("click", function (e) {
    e.stopPropagation(); // Prevent event from bubbling up
    const dropdown = document.querySelector(".notification-dropdown");
    const isVisible = dropdown.style.display === "block";

    // Close all other dropdowns first
    document.querySelectorAll(".notification-dropdown").forEach((d) => {
      d.style.display = "none";
    });

    // Toggle this dropdown
    dropdown.style.display = isVisible ? "none" : "block";
  });

// Close dropdown when clicking outside
document.addEventListener("click", function (e) {
  if (!e.target.closest(".notification")) {
    document.querySelector(".notification-dropdown").style.display = "none";
  }
});

// Prevent dropdown from closing when clicking inside it
document
  .querySelector(".notification-dropdown")
  .addEventListener("click", function (e) {
    e.stopPropagation();
  });
// Add after your existing document.ready function
const generateSoaBtn = document.getElementById("generateSoaBtn");
const soaModal = document.getElementById("soaModal");
const previewSoaBtn = document.getElementById("previewSoaBtn");
const downloadSoaBtn = document.getElementById("downloadSoaBtn");
const loanSelect = document.getElementById("loanSelect");

// Enable SOA button when borrower is selected
function enableSoaButton() {
  generateSoaBtn.disabled = !originalValues?.id;
}

// Load loans for SOA generation
function loadLoanOptions(borrowerId) {
  const loanSelect = document.getElementById("loanSelect");
  loanSelect.innerHTML = '<option value="">Select a loan transaction</option>';

  fetch(`scripts/AJAX/get_borrower_loans.php?borrowerId=${borrowerId}`)
    .then((response) => response.json())
    .then((loans) => {
      if (Array.isArray(loans)) {
        loans.forEach((loan) => {
          const option = document.createElement("option");
          option.value = loan.id;
          option.textContent = `Loan #${loan.reference_no} - ${new Date(
            loan.loan_date
          ).toLocaleDateString()} (₱${parseFloat(
            loan.loan_amount
          ).toLocaleString()})`;
          loanSelect.appendChild(option);
        });
        // Enable the preview button if loans are available
        document.getElementById("previewSoaBtn").disabled = loans.length === 0;
      }
    })
    .catch((error) => {
      console.error("Error loading loans:", error);
      Swal.fire({
        icon: "error",
        title: "Error",
        text: "Failed to load loan data",
      });
    });
}

// Handle SOA button click
generateSoaBtn.addEventListener("click", () => {
  if (!originalValues || !originalValues.id) {
    Swal.fire("Error", "Please select a borrower first", "error");
    return;
  }

  loadLoanOptions(originalValues.id);
  soaModal.style.display = "block";
});

// Preview SOA
previewSoaBtn.addEventListener("click", () => {
  const loanId = loanSelect.value;
  if (!loanId) {
    Swal.fire("Error", "Please select a loan transaction", "error");
    return;
  }

  // Open SOA in new window
  window.open(
    `soa.php?borrowerId=${originalValues.id}&loanId=${loanId}`,
    "_blank"
  );
});

// Download SOA
downloadSoaBtn.addEventListener("click", async () => {
  const loanId = loanSelect.value;
  if (!loanId) {
    Swal.fire("Error", "Please select a loan transaction", "error");
    return;
  }

  try {
    const response = await fetch("scripts/AJAX/generate_soa.php", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        borrowerId: originalValues.id,
        loanId: loanId,
      }),
    });

    const data = await response.json();
    if (data.status === "success") {
      // Create form for download
      const form = document.createElement("form");
      form.method = "POST";
      form.action = "scripts/AJAX/download_soa.php";
      form.target = "_blank";

      const dataInput = document.createElement("input");
      dataInput.type = "hidden";
      dataInput.name = "soa_data";
      dataInput.value = JSON.stringify(data.data);

      form.appendChild(dataInput);
      document.body.appendChild(form);
      form.submit();
      document.body.removeChild(form);
    } else {
      throw new Error(data.message || "Failed to generate SOA");
    }
  } catch (error) {
    console.error("Error:", error);
    Swal.fire("Error", error.message, "error");
  }
});

// Close modal when clicking the close button
document
  .querySelector('[data-modal="soaModal"]')
  .addEventListener("click", () => {
    soaModal.style.display = "none";
  });

generateSoaBtn.addEventListener("click", () => {
  if (!originalValues || !originalValues.id) {
    Swal.fire({
      icon: "error",
      title: "Error",
      text: "Please select a borrower first",
    });
    return;
  }

  loadLoanOptions(originalValues.id);
  soaModal.style.display = "block";
});

// Preview SOA handler
previewSoaBtn.addEventListener("click", () => {
  const loanId = loanSelect.value;
  if (!loanId) {
    Swal.fire({
      icon: "error",
      title: "Error",
      text: "Please select a loan to generate SOA",
    });
    return;
  }

  const soaUrl = `soa.php?borrowerId=${originalValues.id}&loanId=${loanId}`;
  const previewWindow = window.open(soaUrl, "_blank");

  // Enable download button after preview
  downloadSoaBtn.disabled = false;
});

// Download SOA handler
downloadSoaBtn.addEventListener("click", () => {
  const loanId = loanSelect.value;
  if (!loanId) {
    Swal.fire({
      icon: "error",
      title: "Error",
      text: "Please select a loan to download SOA",
    });
    return;
  }

  const soaUrl = `soa.php?borrowerId=${originalValues.id}&loanId=${loanId}&download=true`;
  window.location.href = soaUrl;
});
