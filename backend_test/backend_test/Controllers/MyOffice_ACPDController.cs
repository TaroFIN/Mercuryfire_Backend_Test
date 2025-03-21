using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.Data.SqlClient;
using System.Text.Json;

[Route("api/[controller]")]
[ApiController]
public class MyOffice_ACPDController : ControllerBase
{
    private readonly string _connectionString;

    public MyOffice_ACPDController(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
    }

    // GET: api/MyOffice_ACPD
    [HttpGet]
    public async Task<ActionResult<string>> GetMyOffice_ACPDs()
    {
        var jsonResult = string.Empty;
        using (var connection = new SqlConnection(_connectionString))
        {
            var command = new SqlCommand("Exec GetMyOffice_ACPDs", connection);
            await connection.OpenAsync();
            using (var reader = await command.ExecuteReaderAsync())
            {
                var dataTable = new DataTable();
                dataTable.Load(reader);
                jsonResult = JsonSerializer.Serialize(dataTable);
            }
        }
        return jsonResult;
    }

    // GET: api/MyOffice_ACPD/5
    [HttpGet("{id}")]
    public async Task<ActionResult<string>> GetMyOffice_ACPD(string id)
    {
        var jsonResult = string.Empty;
        using (var connection = new SqlConnection(_connectionString))
        {
            var command = new SqlCommand("Exec GetMyOffice_ACPD @id", connection);
            command.Parameters.AddWithValue("@id", id);
            await connection.OpenAsync();
            using (var reader = await command.ExecuteReaderAsync())
            {
                var dataTable = new DataTable();
                dataTable.Load(reader);
                jsonResult = JsonSerializer.Serialize(dataTable);
            }
        }
        return jsonResult;
    }

    // PUT: api/MyOffice_ACPD/5
    [HttpPut("{id}")]
    public async Task<IActionResult> PutMyOffice_ACPD(string id, [FromBody] JsonElement jsonElement)
    {
        using (var connection = new SqlConnection(_connectionString))
        {
            var command = new SqlCommand("Exec UpdateMyOffice_ACPD @id, @json", connection);
            command.Parameters.AddWithValue("@id", id);
            command.Parameters.AddWithValue("@json", jsonElement.GetRawText());
            await connection.OpenAsync();
            var result = await command.ExecuteNonQueryAsync();
            if (result == 0)
            {
                return NotFound();
            }
        }
        return NoContent();
    }

    // POST: api/MyOffice_ACPD
    [HttpPost]
    public async Task<ActionResult<string>> PostMyOffice_ACPD([FromBody] JsonElement jsonElement)
    {
        using (var connection = new SqlConnection(_connectionString))
        {
            var command = new SqlCommand("Exec InsertMyOffice_ACPD @json", connection);
            command.Parameters.AddWithValue("@json", jsonElement.GetRawText());
            await connection.OpenAsync();
            var result = await command.ExecuteNonQueryAsync();
            if (result == 0)
            {
                return Conflict();
            }
        }
        return CreatedAtAction("GetMyOffice_ACPD", new { id = jsonElement.GetProperty("ACPD_SID").GetString() }, jsonElement);
    }

    // DELETE: api/MyOffice_ACPD/5
    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteMyOffice_ACPD(string id)
    {
        using (var connection = new SqlConnection(_connectionString))
        {
            var command = new SqlCommand("Exec DeleteMyOffice_ACPD @id", connection);
            command.Parameters.AddWithValue("@id", id);
            await connection.OpenAsync();
            var result = await command.ExecuteNonQueryAsync();
            if (result == 0)
            {
                return NotFound();
            }
        }
        return NoContent();
    }
}
