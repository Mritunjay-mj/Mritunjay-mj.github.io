document.getElementById('fetch-data').addEventListener('click', () => {
    fetch('/api/data')
        .then(response => response.json())
        .then(data => {
            document.getElementById('data-display').textContent = JSON.stringify(data);
        })
        .catch(error => {
            console.error('Error fetching data:', error);
            document.getElementById('data-display').textContent = "Error fetching data.";
        });
});

document.getElementById('fetch-secure-data').addEventListener('click', () => {
    fetch('/api/secure_data')
        .then(response => response.json())
        .then(data => {
            document.getElementById('data-display').textContent = JSON.stringify(data);
        })
        .catch(error => {
            console.error('Error fetching secure data:', error);
            document.getElementById('data-display').textContent = "Error fetching secure data.";
        });
});
$(document).ready(function () {
    const table = $('#user-table').DataTable({
        ajax: {
            url: '/api/data',
            dataSrc: '' // Data is expected as an array
        },
        columns: [
            { data: 'id' },
            { data: 'name' },
            { data: 'data1' },
            { data: 'data2' },
            {
                data: null,
                render: function (data, type, row) {
                    return '<a href="/user_details?id=' + row.id + '&name=' + row.name + '&data1=' + row.data1 + '&data2=' + row.data2 + '">Details</a>';
                }
            }
        ]
    });
});