photo-album Cookbook
====================
This cookbook sets up a photo-album application server

Requirements
------------
#### packages
- `puma` - photo-album uses the puma webserver

Attributes
----------

#### photo-album::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt></tt></td>
    <td></td>
    <td></td>
    <td><tt></tt></td>
  </tr>
</table>

Usage
-----
#### photo-album::default
Just include `photo-album` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[photo-album]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Robin Clowers
