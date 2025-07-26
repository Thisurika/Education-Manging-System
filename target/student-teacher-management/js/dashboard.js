// Dashboard JavaScript Functions

// Show/Hide sections
function showSection(sectionId) {
    // Hide all sections
    const sections = document.querySelectorAll('.content-section');
    sections.forEach(section => {
        section.classList.remove('active');
    });
    
    // Show selected section
    const targetSection = document.getElementById(sectionId);
    if (targetSection) {
        targetSection.classList.add('active');
    }
    
    // Update navigation
    const navLinks = document.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
        link.classList.remove('active');
    });
    
    const activeLink = document.querySelector(`a[href="#${sectionId}"]`);
    if (activeLink) {
        activeLink.classList.add('active');
    }
}

// Modal functions
function showModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.style.display = 'block';
        document.body.style.overflow = 'hidden';
        
        // Add fade-in animation
        modal.querySelector('.modal-content').classList.add('fade-in');
    }
}

function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.style.display = 'none';
        document.body.style.overflow = 'auto';
        
        // Clear form if exists
        const form = modal.querySelector('form');
        if (form) {
            form.reset();
        }
    }
}

// Teacher management functions
function showAddTeacherModal() {
    showModal('addTeacherModal');
}

function editTeacher(id, username, name, email, employeeId, subject, department) {
    // Populate edit form
    document.getElementById('editTeacherId').value = id;
    document.getElementById('editTeacherUsername').value = username;
    document.getElementById('editTeacherName').value = name;
    document.getElementById('editTeacherEmail').value = email;
    document.getElementById('editEmployeeId').value = employeeId;
    document.getElementById('editSubject').value = subject;
    document.getElementById('editDepartment').value = department;
    
    showModal('editTeacherModal');
}

function deleteTeacher(teacherId) {
    if (confirm('Are you sure you want to delete this teacher?')) {
        // Create and submit delete form
        const form = document.createElement('form');
        form.method = 'post';
        form.action = 'admin-dashboard';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'deleteTeacher';
        
        const teacherIdInput = document.createElement('input');
        teacherIdInput.type = 'hidden';
        teacherIdInput.name = 'teacherId';
        teacherIdInput.value = teacherId;
        
        form.appendChild(actionInput);
        form.appendChild(teacherIdInput);
        document.body.appendChild(form);
        form.submit();
    }
}

// Student management functions
function showAddStudentModal() {
    showModal('addStudentModal');
}

function editStudent(id, name, email, studentId, grade, className, phone) {
    // Populate edit form
    document.getElementById('editStudentId').value = id;
    document.getElementById('editStudentName').value = name;
    document.getElementById('editStudentEmail').value = email;
    document.getElementById('editStudentNumber').value = studentId;
    document.getElementById('editStudentGrade').value = grade;
    document.getElementById('editClassName').value = className;
    document.getElementById('editStudentPhone').value = phone;
    
    showModal('editStudentModal');
}

function deleteStudent(studentId) {
    if (confirm('Are you sure you want to delete this student?')) {
        // Create and submit delete form
        const form = document.createElement('form');
        form.method = 'post';
        form.action = window.location.pathname;
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'deleteStudent';
        
        const studentIdInput = document.createElement('input');
        studentIdInput.type = 'hidden';
        studentIdInput.name = 'studentId';
        studentIdInput.value = studentId;
        
        form.appendChild(actionInput);
        form.appendChild(studentIdInput);
        document.body.appendChild(form);
        form.submit();
    }
}

// Grade management functions
function addGrade(studentId, studentName) {
    document.getElementById('gradeStudentId').value = studentId;
    document.getElementById('gradeStudentName').value = studentName;
    
    // Set current date
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('gradeDate').value = today;
    
    showModal('addGradeModal');
}

function editGrade(gradeId, studentId, subject, grade) {
    // Populate edit grade form
    document.getElementById('editGradeId').value = gradeId;
    document.getElementById('editGradeStudentId').value = studentId;
    document.getElementById('editGradeSubject').value = subject;
    document.getElementById('editGradeValue').value = grade;
    
    showModal('editGradeModal');
}

function deleteGrade(gradeId) {
    if (confirm('Are you sure you want to delete this grade?')) {
        // Create and submit delete form
        const form = document.createElement('form');
        form.method = 'post';
        form.action = 'grades';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'delete';
        
        const gradeIdInput = document.createElement('input');
        gradeIdInput.type = 'hidden';
        gradeIdInput.name = 'gradeId';
        gradeIdInput.value = gradeId;
        
        form.appendChild(actionInput);
        form.appendChild(gradeIdInput);
        document.body.appendChild(form);
        form.submit();
    }
}

// Profile management
function editProfile() {
    showModal('editProfileModal');
}

// Form validation
function validateForm(formId) {
    const form = document.getElementById(formId);
    const inputs = form.querySelectorAll('input[required], select[required]');
    let isValid = true;
    
    inputs.forEach(input => {
        if (!input.value.trim()) {
            input.style.borderColor = '#e74c3c';
            isValid = false;
        } else {
            input.style.borderColor = '#ecf0f1';
        }
    });
    
    return isValid;
}

// Add loading state to buttons
function addLoadingState(button) {
    button.disabled = true;
    button.classList.add('loading');
    const originalText = button.textContent;
    button.textContent = 'Loading...';
    
    // Remove loading state after 2 seconds (or when response is received)
    setTimeout(() => {
        button.disabled = false;
        button.classList.remove('loading');
        button.textContent = originalText;
    }, 2000);
}

// Search functionality
function searchStudents() {
    const searchInput = document.getElementById('searchInput');
    const searchTerm = searchInput.value.toLowerCase();
    const studentCards = document.querySelectorAll('.student-card');
    
    studentCards.forEach(card => {
        const name = card.querySelector('h3').textContent.toLowerCase();
        const studentId = card.querySelector('p').textContent.toLowerCase();
        
        if (name.includes(searchTerm) || studentId.includes(searchTerm)) {
            card.style.display = 'block';
            card.classList.add('fade-in');
        } else {
            card.style.display = 'none';
        }
    });
}

// Notification system
function showNotification(message, type = 'success') {
    const notification = document.createElement('div');
    notification.className = `notification ${type}-message`;
    notification.textContent = message;
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 1001;
        padding: 15px 20px;
        border-radius: 8px;
        color: white;
        font-weight: 600;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        animation: slideInRight 0.3s ease;
    `;
    
    document.body.appendChild(notification);
    
    // Remove notification after 3 seconds
    setTimeout(() => {
        notification.style.animation = 'slideOutRight 0.3s ease';
        setTimeout(() => {
            document.body.removeChild(notification);
        }, 300);
    }, 3000);
}

// Initialize dashboard
document.addEventListener('DOMContentLoaded', function() {
    // Close modals when clicking outside
    window.addEventListener('click', function(event) {
        if (event.target.classList.contains('modal')) {
            const modalId = event.target.id;
            closeModal(modalId);
        }
    });
    
    // Add form submission handlers
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            const submitButton = form.querySelector('button[type="submit"]');
            if (submitButton) {
                addLoadingState(submitButton);
            }
        });
    });
    
    // Add input validation
    const inputs = document.querySelectorAll('input, select');
    inputs.forEach(input => {
        input.addEventListener('blur', function() {
            if (this.hasAttribute('required') && !this.value.trim()) {
                this.style.borderColor = '#e74c3c';
            } else {
                this.style.borderColor = '#ecf0f1';
            }
        });
        
        input.addEventListener('input', function() {
            if (this.style.borderColor === 'rgb(231, 76, 60)' && this.value.trim()) {
                this.style.borderColor = '#ecf0f1';
            }
        });
    });
    
    // Add smooth scrolling for navigation
    const navLinks = document.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            if (this.getAttribute('href').startsWith('#')) {
                e.preventDefault();
                const targetId = this.getAttribute('href').substring(1);
                showSection(targetId);
            }
        });
    });
    
    // Add keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Escape key to close modals
        if (e.key === 'Escape') {
            const openModal = document.querySelector('.modal[style*="block"]');
            if (openModal) {
                closeModal(openModal.id);
            }
        }
        
        // Ctrl+N for new student/teacher
        if (e.ctrlKey && e.key === 'n') {
            e.preventDefault();
            const addStudentBtn = document.querySelector('button[onclick="showAddStudentModal()"]');
            const addTeacherBtn = document.querySelector('button[onclick="showAddTeacherModal()"]');
            
            if (addStudentBtn && addStudentBtn.offsetParent !== null) {
                showAddStudentModal();
            } else if (addTeacherBtn && addTeacherBtn.offsetParent !== null) {
                showAddTeacherModal();
            }
        }
    });
    
    // Add animation classes to elements as they come into view
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('fade-in');
            }
        });
    }, observerOptions);
    
    // Observe cards and other elements
    const cards = document.querySelectorAll('.student-card, .teacher-card, .stat-card');
    cards.forEach(card => {
        observer.observe(card);
    });
});

// Utility functions
function formatDate(date) {
    return new Intl.DateTimeFormat('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    }).format(new Date(date));
}

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

// Export functions for global use
window.showSection = showSection;
window.showModal = showModal;
window.closeModal = closeModal;
window.showAddTeacherModal = showAddTeacherModal;
window.editTeacher = editTeacher;
window.deleteTeacher = deleteTeacher;
window.showAddStudentModal = showAddStudentModal;
window.editStudent = editStudent;
window.deleteStudent = deleteStudent;
window.addGrade = addGrade;
window.editGrade = editGrade;
window.deleteGrade = deleteGrade;
window.editProfile = editProfile;
window.showNotification = showNotification;

// Additional functions for bookstore management
function showAddBookModal() {
    showModal('addBookModal');
}

function editBook(id, title, author, genre, price, imageUrl, quantity) {
    document.getElementById('editBookId').value = id;
    document.getElementById('editTitle').value = title;
    document.getElementById('editAuthor').value = author;
    document.getElementById('editGenre').value = genre;
    document.getElementById('editPrice').value = price;
    document.getElementById('editImageUrl').value = imageUrl;
    document.getElementById('editQuantity').value = quantity;
    
    showModal('editBookModal');
}

function deleteBook(bookId) {
    if (confirm('Are you sure you want to delete this book?')) {
        const form = document.createElement('form');
        form.method = 'post';
        form.action = 'cashier-dashboard';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'delete';
        
        const bookIdInput = document.createElement('input');
        bookIdInput.type = 'hidden';
        bookIdInput.name = 'bookId';
        bookIdInput.value = bookId;
        
        form.appendChild(actionInput);
        form.appendChild(bookIdInput);
        document.body.appendChild(form);
        form.submit();
    }
}

function showAddCashierModal() {
    showModal('addCashierModal');
}

function editCashier(id, username, name, email, employeeId, department) {
    document.getElementById('editId').value = id;
    document.getElementById('editUsername').value = username;
    document.getElementById('editName').value = name;
    document.getElementById('editEmail').value = email;
    document.getElementById('editEmployeeId').value = employeeId;
    document.getElementById('editDepartment').value = department;
    
    showModal('editCashierModal');
}

function deleteCashier(cashierId) {
    if (confirm('Are you sure you want to delete this cashier?')) {
        const form = document.createElement('form');
        form.method = 'post';
        form.action = 'manager-dashboard';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'delete';
        
        const cashierIdInput = document.createElement('input');
        cashierIdInput.type = 'hidden';
        cashierIdInput.name = 'cashierId';
        cashierIdInput.value = cashierId;
        
        form.appendChild(actionInput);
        form.appendChild(cashierIdInput);
        document.body.appendChild(form);
        form.submit();
    }
}

// Export additional functions
window.showAddBookModal = showAddBookModal;
window.editBook = editBook;
window.deleteBook = deleteBook;
window.showAddCashierModal = showAddCashierModal;
window.editCashier = editCashier;
window.deleteCashier = deleteCashier;