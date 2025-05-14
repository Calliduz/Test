import React, { useState, useEffect } from 'react';
import { X, Edit, Trash, Plus } from 'lucide-react';
import { Category, PredefinedItem, Unit } from '../types';

interface ManageCategoriesModalProps {
  categories: Category;
  onClose: () => void;
  onUpdateCategories: (categories: Category) => void;
}

const ManageCategoriesModal: React.FC<ManageCategoriesModalProps> = ({ 
  categories, 
  onClose, 
  onUpdateCategories 
}) => {
  const [categoryType, setCategoryType] = useState<string>(Object.keys(categories)[0] || 'agricultural');
  const [selectedSubcategory, setSelectedSubcategory] = useState<string | null>(null);
  const [newSubcategoryName, setNewSubcategoryName] = useState<string>('');
  const [newItemName, setNewItemName] = useState<string>('');
  const [newItemUnit, setNewItemUnit] = useState<Unit>('Kgs');
  const [workingCategories, setWorkingCategories] = useState<Category>({ ...categories });

  // Update selected subcategory when category type changes
  useEffect(() => {
    setSelectedSubcategory(null);
  }, [categoryType]);

  // Handle adding a new subcategory
  const handleAddSubcategory = () => {
    if (!newSubcategoryName.trim()) {
      alert("Please enter a subcategory name.");
      return;
    }

    // Check if the category exists
    if (!workingCategories[categoryType]) {
      alert("Selected category type does not exist.");
      return;
    }

    // Initialize subcategories if they don't exist
    if (!workingCategories[categoryType].subcategories) {
      const updatedCategories = { ...workingCategories };
      updatedCategories[categoryType].subcategories = {};
      setWorkingCategories(updatedCategories);
    }

    // Generate a key for the new subcategory
    const key = newSubcategoryName.toLowerCase().replace(/[^a-z0-9]/g, "-");

    // Check if the key already exists
    if (workingCategories[categoryType].subcategories[key]) {
      alert("A subcategory with this name already exists.");
      return;
    }

    // Add the new subcategory
    const updatedCategories = { ...workingCategories };
    updatedCategories[categoryType].subcategories[key] = {
      label: newSubcategoryName,
      predefinedItems: []
    };

    setWorkingCategories(updatedCategories);
    setNewSubcategoryName('');
  };

  // Handle deleting a subcategory
  const handleDeleteSubcategory = (subcategoryKey: string) => {
    // Check if the category exists
    if (!workingCategories[categoryType]) {
      alert("Selected category type does not exist.");
      return;
    }

    // Confirm deletion
    if (!window.confirm(`Are you sure you want to delete this subcategory?`)) {
      return;
    }

    // Check if this is a system category
    if (workingCategories[categoryType].subcategories[subcategoryKey].system) {
      alert("Cannot delete system categories.");
      return;
    }

    // Delete the subcategory
    const updatedCategories = { ...workingCategories };
    delete updatedCategories[categoryType].subcategories[subcategoryKey];

    setWorkingCategories(updatedCategories);
    if (selectedSubcategory === subcategoryKey) {
      setSelectedSubcategory(null);
    }
  };

  // Handle adding a predefined item
  const handleAddPredefinedItem = () => {
    if (!selectedSubcategory || !workingCategories[categoryType]) return;
    
    if (!newItemName.trim()) {
      alert("Please enter an item name.");
      return;
    }

    // Check if item already exists (case insensitive)
    const items = workingCategories[categoryType].subcategories[selectedSubcategory].predefinedItems;
    const existingItem = items.find(item => 
      item.name.toLowerCase() === newItemName.toLowerCase()
    );

    if (existingItem) {
      if (existingItem.unit !== newItemUnit) {
        alert(`This item already exists with unit "${existingItem.unit}". You cannot add the same item with a different unit.`);
        return;
      }
      alert("This item already exists.");
      return;
    }

    // Check if this subcategory already has 100 items
    if (items.length >= 100) {
      alert("This category has reached the maximum limit of 100 items.");
      return;
    }

    // Add the new item
    const updatedCategories = { ...workingCategories };
    updatedCategories[categoryType].subcategories[selectedSubcategory].predefinedItems.push({
      name: newItemName,
      unit: newItemUnit
    });

    setWorkingCategories(updatedCategories);
    setNewItemName('');
  };

  // Handle deleting a predefined item
  const handleDeletePredefinedItem = (index: number) => {
    if (!selectedSubcategory || !workingCategories[categoryType]) return;

    const updatedCategories = { ...workingCategories };
    updatedCategories[categoryType].subcategories[selectedSubcategory].predefinedItems.splice(index, 1);

    setWorkingCategories(updatedCategories);
  };

  // Handle saving changes
  const handleSave = () => {
    onUpdateCategories(workingCategories);
    onClose();
  };

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-xl shadow-xl max-w-md w-full max-h-[90vh] overflow-y-auto p-6 relative">
        <button 
          onClick={onClose}
          className="absolute top-4 right-4 text-gray-500 hover:text-gray-700"
        >
          <X className="h-6 w-6" />
        </button>
        
        <h2 className="text-xl font-semibold mb-6 pr-8">Manage Categories</h2>
        
        <div className="space-y-6">
          <div>
            <label htmlFor="categoryType" className="block text-sm font-medium text-gray-700 mb-1">
              Category Type:
            </label>
            <select
              id="categoryType"
              className="w-full p-2 border border-gray-300 rounded-lg bg-gray-50 text-gray-800"
              value={categoryType}
              onChange={(e) => setCategoryType(e.target.value)}
            >
              {Object.keys(workingCategories).map(key => (
                <option key={key} value={key}>{workingCategories[key].label}</option>
              ))}
            </select>
          </div>
          
          <div>
            <h3 className="font-medium text-gray-800 mb-2">Subcategories:</h3>
            <div className="max-h-[200px] overflow-y-auto space-y-2 mb-4">
              {categoryType && workingCategories[categoryType] && 
                Object.keys(workingCategories[categoryType].subcategories).map(key => {
                  const subcategory = workingCategories[categoryType].subcategories[key];
                  const isSystem = subcategory.system;
                  
                  return (
                    <div 
                      key={key}
                      className={`flex justify-between items-center p-3 border rounded-lg ${
                        selectedSubcategory === key ? 'bg-green-50 border-green-300' : 'bg-gray-50 border-gray-200'
                      } hover:bg-gray-100 cursor-pointer`}
                      onClick={() => setSelectedSubcategory(key)}
                    >
                      <span>{subcategory.label}</span>
                      <div className="flex gap-2">
                        <button
                          type="button"
                          className="p-1 text-teal-700 hover:text-teal-900 hover:bg-teal-100 rounded"
                          onClick={(e) => {
                            e.stopPropagation();
                            setSelectedSubcategory(key);
                          }}
                          title="Edit Items"
                        >
                          <Edit className="h-4 w-4" />
                        </button>
                        {!isSystem && (
                          <button
                            type="button"
                            className="p-1 text-red-600 hover:text-red-800 hover:bg-red-100 rounded"
                            onClick={(e) => {
                              e.stopPropagation();
                              handleDeleteSubcategory(key);
                            }}
                            title="Delete"
                          >
                            <Trash className="h-4 w-4" />
                          </button>
                        )}
                      </div>
                    </div>
                  );
                })
              }
            </div>
            
            <div className="flex gap-2">
              <input
                type="text"
                className="flex-grow p-2 border border-gray-300 rounded-lg bg-gray-50 text-gray-800"
                placeholder="New subcategory name"
                value={newSubcategoryName}
                onChange={(e) => setNewSubcategoryName(e.target.value)}
              />
              <button
                type="button"
                className="bg-green-700 hover:bg-green-800 text-white p-2 rounded-lg"
                onClick={handleAddSubcategory}
              >
                <Plus className="h-5 w-5" />
              </button>
            </div>
          </div>
          
          {selectedSubcategory && workingCategories[categoryType] && (
            <div className="border-t pt-4">
              <h3 className="font-medium text-gray-800 mb-2">
                Predefined Items for {workingCategories[categoryType].subcategories[selectedSubcategory].label}:
              </h3>
              <div className="max-h-[200px] overflow-y-auto space-y-2 mb-4">
                {workingCategories[categoryType].subcategories[selectedSubcategory].predefinedItems.map((item, index) => (
                  <div 
                    key={index}
                    className="flex justify-between items-center p-3 border border-gray-200 rounded-lg bg-gray-50"
                  >
                    <span>
                      {item.name} <span className="text-gray-500 text-sm">({item.unit})</span>
                    </span>
                    <button
                      type="button"
                      className="p-1 text-red-600 hover:text-red-800 hover:bg-red-100 rounded"
                      onClick={() => handleDeletePredefinedItem(index)}
                      title="Delete"
                    >
                      <Trash className="h-4 w-4" />
                    </button>
                  </div>
                ))}
              </div>
              
              <div className="space-y-2">
                <input
                  type="text"
                  className="w-full p-2 border border-gray-300 rounded-lg bg-gray-50 text-gray-800"
                  placeholder="New item name"
                  value={newItemName}
                  onChange={(e) => setNewItemName(e.target.value)}
                />
                
                <div className="flex gap-4 mb-2">
                  <label className="inline-flex items-center">
                    <input
                      type="radio"
                      name="newItemUnit"
                      value="Kgs"
                      checked={newItemUnit === 'Kgs'}
                      onChange={() => setNewItemUnit('Kgs')}
                      className="h-4 w-4 text-green-600"
                    />
                    <span className="ml-2">Kgs</span>
                  </label>
                  <label className="inline-flex items-center">
                    <input
                      type="radio"
                      name="newItemUnit"
                      value="Pcs"
                      checked={newItemUnit === 'Pcs'}
                      onChange={() => setNewItemUnit('Pcs')}
                      className="h-4 w-4 text-green-600"
                    />
                    <span className="ml-2">Pcs</span>
                  </label>
                </div>
                
                <button
                  type="button"
                  className="w-full bg-green-700 hover:bg-green-800 text-white py-2 px-4 rounded-lg transition-colors"
                  onClick={handleAddPredefinedItem}
                >
                  Add Item
                </button>
              </div>
            </div>
          )}
          
          <div className="pt-4 border-t">
            <button
              type="button"
              className="w-full bg-green-700 hover:bg-green-800 text-white py-2 px-4 rounded-lg transition-colors"
              onClick={handleSave}
            >
              Save Changes
            </button>
            <button
              type="button"
              onClick={onClose}
              className="w-full mt-2 bg-gray-200 hover:bg-gray-300 text-gray-800 py-2 px-4 rounded-lg transition-colors"
            >
              Cancel
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ManageCategoriesModal;