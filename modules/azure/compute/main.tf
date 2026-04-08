resource "azurerm_network_security_group" "this" {
  name                = "${var.name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-http"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Name = "${var.name}-nsg"
  }
}

//Load Balancer Config 
resource "azurerm_public_ip" "lb" {
  name                = "${var.name}-lb-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Name = "${var.name}-lb-pip"
  }
}

resource "azurerm_lb" "this" {
  name = "${var.name}-lb"
  location = var.location
  resource_group_name = var.resource_group_name
  sku = "Standard"

  frontend_ip_configuration {
    name = "${var.name}-frontend"
    public_ip_address_id = azurerm_public_ip.lb.id 
  }

  tags = {
    Name = "${var.name}-lb"
  }
}

resource "azurerm_lb_backend_address_pool" "this" {
  loadbalancer_id = azurerm_lb.this.id 
  name = "${var.name}-backend-pool"
}

resource "azurerm_lb_probe" "http" {
  loadbalancer_id = azurerm_lb.this.id 
  name = "${var.name}-http-probe"
  protocol = "Http"
  port = 80
  request_path = "/"
}

resource "azurerm_lb_rule" "http" {
  loadbalancer_id = azurerm_lb.this.id 
  name = "${var.name}-http-rule"
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 80
  frontend_ip_configuration_name = "${var.name}-frontend"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.this.id]
  probe_id = azurerm_lb_probe.http.id 
}

resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name = "${var.name}-vmss"
  resource_group_name = var.resource_group_name
  location = var.location
  sku = var.vm_size
  instances = var.instance_count
  admin_username = var.admin_username
  disable_password_authentication = true 

  admin_ssh_key {
    username = var.admin_username
    public_key = var.ssh_public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts"
    version = "latest"
  }

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  computer_name_prefix = "vmss"

  custom_data = base64encode(<<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              systemctl enable apache2
              systemctl start apache2
              echo "<h1>${var.name} app server</h1>" > /var/www/html/index.html
              echo "<p>Hostname: $(hostname)</p>" >> /var/www/html/index.html
              EOF
  )

  network_interface {
    name = "${var.name}-vmss-nic"
    primary = true 

    ip_configuration {
      name = "internal"
      primary = true 
      subnet_id = var.subnet_id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.this.id]      
    }
    network_security_group_id = azurerm_network_security_group.this.id
  }

  tags = {
    Name = "${var.name}-vmss"
  } 
}



