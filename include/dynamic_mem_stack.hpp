/**
 * @file dynamic_mem_stack.hpp
 * @author Pojmaevich Mirko (mirkopoj@gmail.com)
 *         Torletti Lara (lara.a.torletti@gmail.com)
 * @brief
 * @version 0.1
 * @date 2024-05-01
 *
 * @copyright Copyright (c) 2024
 *
 */
#pragma once
#include "stack_interface.hpp"

#ifndef DYNAMIC_STACK_INITIAL_CAPACITY
#define DYNAMIC_STACK_INITIAL_CAPACITY 10
#endif // !DYNAMIC_STACK_INITIAL_CAPACITY

class DynamicMemStack : public Stack {
  public:
    DynamicMemStack();
    DynamicMemStack(size_t);
    DynamicMemStack(size_t, StackableObject **new_arr(size_t len),
                    void delete_arr(StackableObject **ptr));
    DynamicMemStack(DynamicMemStack &&) = delete;
    DynamicMemStack(const DynamicMemStack &) = delete;
    DynamicMemStack &operator=(DynamicMemStack &&) = delete;
    DynamicMemStack &operator=(const DynamicMemStack &) = delete;
    ~DynamicMemStack();

    virtual bool push(StackableObject *const) override;
    virtual StackableObject *pop() override;
    virtual size_t get_count() const override;

  private:
    StackableObject **stack;
    size_t count;
    size_t capacity;
};
